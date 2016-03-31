require 'will_paginate/array'

class SuIncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper

  def index
    records = SuIncomingRecord.joins(:incoming_file_record).where("file_name=? and status=?",params[:file_name],params[:status]).order("id desc")
    records = find_su_incoming_records(params,records)
    @records_count = records.count(:status)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @su_record = SuIncomingRecord.find_by_id(params[:id])
  end

  def audit_steps
    @su_record = SuIncomingRecord.find(params[:id])
    su_record_values = find_logs(params, @su_record)
    @su_record_values_count = su_record_values.count(:id)
    @su_record_values = su_record_values.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @record = IncomingFileRecord.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end
end