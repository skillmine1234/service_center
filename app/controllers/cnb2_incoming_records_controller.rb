require 'will_paginate/array'

class Cnb2IncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper

  def index
    @incoming_file = IncomingFile.find_by_file_name(params[:file_name]) rescue nil
    if request.get?
      # only 'safe/non-personal' parameters are allowed as search parameters in a query string
      @searcher = Cnb2IncomingRecordSearcher.new(params.permit(:status,:file_name,:overrided_flag))
    else
      # rest parameters are in post
      @searcher = Cnb2IncomingRecordSearcher.new(search_params)
    end
    @records = @searcher.paginate
  end

  def show
    @cnb2_record = Cnb2IncomingRecord.find_by_id(params[:id])
  end

  def audit_logs
    @record = IncomingFileRecord.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def incoming_file_summary
    @summary = Cnb2IncomingFile.find_by_file_name(params[:file_name])
  end

  private

  def search_params
    params.permit(:page, :pay_comp_code, :vendor_code, :bene_account_no, :status, :file_name, :overrided_flag)
  end
end