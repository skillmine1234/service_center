require 'will_paginate/array'

class IcIncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper
  include IcIncomingRecordsHelper

  def index
    records = IcIncomingRecord.joins(:incoming_file_record).where("file_name=? and status=?",params[:file_name],params[:status]).order("id desc")
    p records
    records = find_ic_incoming_records(params,records)
    p records
    @records_count = records.count(:status)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @ic_record = IcIncomingRecord.find_by_id(params[:id])
  end

  def audit_steps
    @ic_record = IcIncomingRecord.find(params[:id])
    ic_record_values = find_ic_logs(params, @ic_record)
    @ic_record_values_count = ic_record_values.count(:id)
    @ic_record_values = ic_record_values.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @record = IncomingFileRecord.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def update_multiple
    if params[:record_ids]
      @records = IcIncomingRecord.find(params[:record_ids])
      result = check_records(@records,params)
      if result.empty?
        @records = params[:status] == 'skip' ? skip_records(@records,params) : override_records(@records,params)
        flash[:notice] = "Updated records!"
      else
        flash[:notice] = "Please select only records which can be " + params[:status]
      end
    else
      flash[:notice] = "You haven't selected any records!"
    end    
    redirect_to :back
  end
end