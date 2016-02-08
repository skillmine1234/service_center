require 'will_paginate/array'

class OutgoingFilesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include OutgoingFilesHelper
  
  def index
    if params[:advanced_search].present?
      outgoing_files = find_outgoing_files(params).order("id desc")
    else
      outgoing_files = OutgoingFile.order("id desc")
    end 
    @files_count = outgoing_files.count
    @outgoing_files = outgoing_files.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @outgoing_file = OutgoingFile.find(params[:id])    
    require 'uri/open-scp'
    data = open("scp://iibadm@#{ENV['CONFIG_URL_IIB_FILE_MGR']}#{@outgoing_file.file_path}").read
    render plain: data
  end
end
