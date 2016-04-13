require 'will_paginate/array'

class SuIncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper

  def index
    @incoming_file = IncomingFile.find_by_file_name(params[:file_name]) rescue nil
    records = SuIncomingRecord.joins(:incoming_file_record).where("su_incoming_records.file_name=? and status=?",params[:file_name],params[:status]).order("su_incoming_records.id desc")
    records = find_su_incoming_records(params,records)
    @records_count = records.count(:status)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @su_record = SuIncomingRecord.find_by_id(params[:id])
  end

  def audit_logs
    @record = IncomingFileRecord.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end
end