require 'will_paginate/array'

class CnIncomingRecordsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper
  include CnIncomingRecordsHelper

  def index
    @incoming_file = IncomingFile.find_by_file_name(params[:file_name]) rescue nil
    records = CnIncomingRecord.joins(:incoming_file_record).where("cn_incoming_records.file_name=? and status=?",params[:file_name],params[:status]).order("cn_incoming_records.id desc")
    records = find_cn_incoming_records(params,records)
    @records_count = records.count(:status)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @cn_record = CnIncomingRecord.find_by_id(params[:id])
  end

  def audit_logs
    @record = IncomingFileRecord.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def incoming_file_summary
    @summary = CnIncomingFile.find_by_file_name(params[:file_name])
  end

  def download_file
    require 'uri/open-scp'
    @summary = CnIncomingFile.find(params[:id])
    file_name = (params[:flag] == 'rej' ? @summary.try(:rej_file_name) : (params[:flag] == 'cnb' ? @summary.try(:cnb_file_name) : ''))
    file_path = (params[:flag] == 'rej' ? @summary.try(:rej_file_path) : (params[:flag] == 'cnb' ? @summary.try(:cnb_file_path) : ''))
    cmd = "scp://iibadm@#{ENV['CONFIG_SCP_IIB_FILE_MGR']}" unless ENV['CONFIG_SCP_IIB_FILE_MGR'] = '127.0.0.1'
    data = open("#{cmd}#{file_path}/#{file_name}").read rescue ""
    if data.to_s.empty?
      flash[:alert] = "File not found!"
      redirect_to cn_incoming_file_summary_path(file_name: @summary.try(:file_name))
    elsif params[:view].present?
      render plain: data
    elsif params[:download].present?
      send_data data, :filename => file_name
    end
  end
end