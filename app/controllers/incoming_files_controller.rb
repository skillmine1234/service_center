require 'will_paginate/array'

class IncomingFilesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include IncomingFileHelper

  def new
    @incoming_file = IncomingFile.new
    @sc_service = ScService.find_by_code(params[:sc_service])
  end

  def create
    @incoming_file = IncomingFile.new(params[:incoming_file])
    if @incoming_file.save
      flash[:alert] = "File is successfully uploaded and is pending for approval"
      redirect_to incoming_files_path
    else
      flash[:notice] = @incoming_file.errors.full_messages
      render :new
    end
  end

  def index
    @sc_service = ScService.find_by_code(params[:sc_service])
    if params[:advanced_search].present?
      incoming_files = find_incoming_files(params).order("id desc")
    else
      incoming_files = (params[:approval_status].present? and params[:approval_status] == 'U') ? IncomingFile.unscoped.where("approval_status=? and service_name=?",'U',params[:sc_service]).order("id desc") : IncomingFile.order("id desc").where(:service_name => params[:sc_service])
    end 
    @files_count = incoming_files.count
    @incoming_files = incoming_files.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def view_raw_content
    @incoming_file = IncomingFile.unscoped.find_by_id(params[:id])
    file_extension = Rack::Mime::MIME_TYPES.invert[@incoming_file.file.content_type].split(".").last if @incoming_file.file.content_type
    if File.exists?(@incoming_file.is_approved?[:file_path])
      if file_extension == IncomingFile::ExtensionList[0]
        @raw_file_content = %x(cat -nb #{@incoming_file.is_approved?[:file_path]})
        @result = {filename: @incoming_file.file_name, content: @raw_file_content}
        respond_to do |format|
          format.html
          format.json { render json: @result }
        end
      # else
      #   send_file @incoming_file.is_approved?[:file_path], :disposition => 'inline'
      end
    else
      @result = {filename: @incoming_file.file_name, content: "File not found."}
      respond_to do |format|
        format.html
        format.json { render json: @result }
      end
    end
  end

  def show
    @incoming_file = IncomingFile.unscoped.find_by_id(params[:id])
    @success_count = @incoming_file.incoming_file_records.where(:status => "COMPLETED").count(:id)
    @failure_count = @incoming_file.incoming_file_records.where("status=? and should_skip=? and overrides is null","FAILED",'N').count(:id)
    @skipped_count = @incoming_file.incoming_file_records.where(:status => "SKIPPED").count(:id)
    @skipped_failure_count = @incoming_file.incoming_file_records.where(:status => "FAILED", :should_skip => 'Y').count(:id)
    @overriden_failure_count = @incoming_file.incoming_file_records.where("status=? and overrides is not null",'FAILED').count(:id)
  end

  def destroy
    @incoming_file = IncomingFile.unscoped.find_by_id(params[:id])
    if @incoming_file.status == "N"
      if @incoming_file.destroy
        FileUtils.rm_f @incoming_file.file.path
      end
    else
      flash[:alert] = "delete is disabled since the file has already been proccessed"
    end
    redirect_to incoming_files_path(:approval_status => 'U')
  end

  def approve
    @incoming_file = IncomingFile.unscoped.find(params[:id]) rescue nil 
    IncomingFile.transaction do
      approval = @incoming_file.approve
      if @incoming_file.save and approval.empty?
        move_incoming_file(@incoming_file)
        flash[:alert] = "Incoming File record was approved successfully"
      else
        msg = approval.empty? ? @incoming_file.errors.full_messages : @incoming_file.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @incoming_file
  end
  
  def download_response_file
    require 'uri/open-scp'
    @incoming_file = IncomingFile.find(params[:id]) 
    data = open("scp://iibadm@#{ENV['CONFIG_URL_IIB_FILE_MGR']}#{@incoming_file.rep_file_path}/#{@incoming_file.rep_file_name}").read rescue ""
    if data.empty?
      flash[:alert] = "File not found!"
      redirect_to @incoming_file
    elsif params[:view].present?
      render plain: data
    elsif params[:download].present?
      send_data data
    end
  end

  def approve_restart
    @incoming_file = IncomingFile.find(params[:id]) 
    @incoming_file.update_attribute(:pending_approval, "N")
    redirect_to @incoming_file
    rescue ActiveRecord::StaleObjectError
      @incoming_file.reload
      flash[:alert] = 'Someone edited the incoming_file the same time you did. Please re-apply your changes to the incoming_file.'
      redirect_to @incoming_file
  end

  def generate_response_file
    @incoming_file = IncomingFile.find(params[:id]) 
    api_req_url = ENV['CONFIG_URL_GEN_RESP_FILE_URI']
    conn = Faraday.new(:url => api_req_url, :ssl => {:verify => false}) do |c|
      c.use Faraday::Request::UrlEncoded
      c.use Faraday::Response::Logger
      c.use Faraday::Adapter::NetHttp
    end
    response = conn.post "#{api_req_url}?incoming_file_id=#{@incoming_file.id}"
    status_code = response.env.status
    flash[:alert] = "Api was hit and Status code of response is #{status_code}"
    redirect_to @incoming_file
  end

  def incoming_file_params
    params.require(:incoming_file).permit(:file, :size_in_bytes, :line_count, :created_by, :updated_by, :status,
                  :lock_version, :file_name, :file_type, :service_name)
  end
end