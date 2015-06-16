require 'will_paginate/array'

class IncomingFilesController < ApplicationController
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
      flash[:alert] = "File is successfully uploaded"
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
      incoming_files = IncomingFile.order("id desc")
    end
    @files_count = incoming_files.count
    @incoming_files = incoming_files.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @incoming_file = IncomingFile.find_by_id(params[:id])
  end

  def destroy
    @incoming_file = IncomingFile.find_by_id(params[:id])
    if @incoming_file.status == "N"
      if @incoming_file.destroy
        FileUtils.rm_f @incoming_file.file.path
      end
    else
      flash[:alert] = "delete is disabled since the file has already been proccessed"
    end
    redirect_to incoming_files_path
  end

  def incoming_file_params
    params.require(:incoming_file).permit(:file, :size_in_bytes, :line_count, :created_by, :updated_by, :status,
                  :lock_version, :file_name, :file_type, :service_name)
  end
end