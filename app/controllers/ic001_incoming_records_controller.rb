require 'will_paginate/array'

class Ic001IncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper

  def index    
    @incoming_file = IncomingFile.find_by_file_name(params[:file_name]) rescue nil
    if request.get?
      # only 'safe/non-personal' parameters are allowed as search parameters in a query string
      @searcher = Ic001IncomingRecordSearcher.new(params.permit(:status, :file_name, :overrided_flag, :page))
    else
      # rest parameters are in post
      @searcher = Ic001IncomingRecordSearcher.new(search_params)
    end
    @records = @searcher.paginate
  end

  def show
    @ic_record = Ic001IncomingRecord.find_by_id(params[:id])
  end

  def audit_logs
    @record = IncomingFileRecord.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def incoming_file_summary
    @summary = Ic001IncomingFile.find_by_file_name(params[:file_name])
  end
  
  def search_params
    params.permit(:page, :anchor_account_id, :from_amount, :to_amount, :invoice_no, :status, :file_name, :overrided_flag)
  end
end