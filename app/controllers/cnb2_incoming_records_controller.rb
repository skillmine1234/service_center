require 'will_paginate/array'

class Cnb2IncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper
  include Cnb2IncomingRecordsHelper

  def index
    @incoming_file = IncomingFile.find_by_file_name(params[:file_name]) rescue nil
    records = Cnb2IncomingRecord.joins(:incoming_file_record).where("cnb2_incoming_records.file_name=? and status=?",params[:file_name],params[:status]).order("cnb2_incoming_records.id desc")
    records = find_cnb2_incoming_records(params,records)
    @records_count = records.count(:status)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
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
    p @summary
    p Cnb2IncomingFile.all
  end
end