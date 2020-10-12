require 'will_paginate/array'

class UnapprovedRecordsController < ApplicationController
  load_and_authorize_resource 
  before_filter :authenticate_user!
  before_filter :block_inactive_user!

  def index
    result = []
    incoming_file_record_ids = IncomingFile.unscoped.where("approval_status =? and service_name=?",'U',params[:sc_service]).pluck(:id)
    @unapproved_records.distinct.select(:approvable_type).each do |m|
      if m.approvable_type.constantize.column_names.include?('approval_status')
        if m.approvable_type == 'IncomingFile'
          count = UnapprovedRecord.where("approvable_type =? and approvable_id IN (?)", m.approvable_type,incoming_file_record_ids).count
        elsif m.approvable_type == 'EcollectRequestTemplate'
           count = UnapprovedRecord.where("approvable_type =?", m.approvable_type).count
        elsif m.approvable_type == 'EcollectResponseTemplate'
           count = UnapprovedRecord.where("approvable_type =?", m.approvable_type).count
        else
          count = UnapprovedRecord.where("approvable_type =?", m.approvable_type).count         
        end
        result << {:record_type => m.approvable_type, :record_count => count}
      end
    end

    @records = result.paginate(:per_page => 10, :page => params[:page]) rescue []
    
    # the approval2 gem requires a known session variable to include any redirect params to be sent to the unapproved_records_path
    # for the reject action
    session[:approval2_redirect_params] = {group_name: params[:group_name], sc_service: params[:sc_service]}
  end

  private

  def unapproved_record_params
    params.require(:unapproved_records).permit(:approvable_type, :approvable_id, :created_at, :updated_at)
  end
end