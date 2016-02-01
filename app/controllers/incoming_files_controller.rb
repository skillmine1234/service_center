require 'will_paginate/array'

class IncomingFilesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include IncomingFileHelper

  def new
    @incoming_file = IncomingFile.new
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
    @failure_count = @incoming_file.incoming_file_records.where(:status => "FAILED").count(:id)
    @skipped_count = @incoming_file.incoming_file_records.where(:status => "SKIPPED").count(:id)
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

  def incoming_file_params
    params.require(:incoming_file).permit(:file, :size_in_bytes, :line_count, :created_by, :updated_by, :status,
                  :lock_version, :file_name, :file_type, :service_name)
  end
end