require 'will_paginate/array'
class RcTransfersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include RcTransfersHelper
  
  def index
    rc_transfers = RcTransfer.order("id desc")
    rc_transfers = find_rc_transfers(params,rc_transfers).order("id desc") if params[:advanced_search].present?
    @rc_transfers_count = rc_transfers.count(:id)
    @rc_transfers = rc_transfers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @rc_transfer = RcTransfer.find_by_id(params[:id])
  end

  def audit_steps
    @record = RcTransfer.find(params[:id])
    record_values = find_logs(params, @record)
    @record_values_count = record_values.count(:id)
    @record_values = record_values.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def update_multiple
    if params[:rc_transfer_ids]
      @rc_transfers = RcTransfer.find(params[:rc_transfer_ids])
      unless @rc_transfers.empty?
        @rc_transfers.each {|rc_transfer| rc_transfer.update_attributes(:pending_approval => "N", :notify_status => 'PENDING NOTIFICATION')}
        flash[:notice] = "Updated transactions!"
      end
    else
      flash[:notice] = "You haven't selected any transaction records!"
    end
    redirect_to :back
  end

  def update
    @rc_transfer = RcTransfer.find(params[:id])
    if @rc_transfer.update_attributes(:pending_approval => 'N', :notify_status => 'PENDING NOTIFICATION')
      flash[:notice] = "RC Transfer is sucessfully updated"
    else
      flash[:notice] = @rc_transfer.errors.full_messages
    end
    redirect_to :back
  end
end
