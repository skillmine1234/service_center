require 'will_paginate/array'

class FpOperationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include FpOperationsHelper

  def new
    @fp_operation = FpOperation.new
  end

  def create
    @fp_operation = FpOperation.new(params[:fp_operation])
    if !@fp_operation.valid?
      render "new"
    else
      @fp_operation.created_by = current_user.id
      @fp_operation.save!
      flash[:alert] = 'FpOperation successfully created and is pending for approval'
      redirect_to @fp_operation
    end
  end 

  def edit
    fp_operation = FpOperation.unscoped.find_by_id(params[:id])
    if fp_operation.approval_status == 'A' && fp_operation.unapproved_record.nil?
      flash[:notice] = "You cannot edit this record as it is already approved!"
      redirect_to fp_operations_path
    end
    @fp_operation = fp_operation  
  end

  def update
    @fp_operation = FpOperation.unscoped.find_by_id(params[:id])
    @fp_operation.attributes = params[:fp_operation]
    if !@fp_operation.valid?
      render "edit"
    else
      @fp_operation.updated_by = current_user.id
      @fp_operation.save!
      flash[:alert] = 'FpOperation successfully modified and is pending for approval'
      redirect_to @fp_operation
    end
    rescue ActiveRecord::StaleObjectError
      @fp_operation.reload
      flash[:alert] = 'Someone edited the fp_operation the same time you did. Please re-apply your changes to the fp_operation.'
      render "edit"
  end 

  def show
    @fp_operation = FpOperation.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      fp_operations = find_fp_operations(params).order("id desc")
    else
      fp_operations = (params[:approval_status].present? and params[:approval_status] == 'U') ? FpOperation.unscoped.where("approval_status =?",'U').order("id desc") : FpOperation.order("id desc")
    end
    @fp_operations_count = fp_operations.count
    @fp_operations = fp_operations.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @fp_operation = FpOperation.unscoped.find(params[:id]) rescue nil
    @audit = @fp_operation.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @fp_operation = FpOperation.unscoped.find(params[:id]) rescue nil
    FpOperation.transaction do
      approval = @fp_operation.approve
      if @fp_operation.save and approval.empty?
        flash[:alert] = "FpOperation record was approved successfully"
      else
        msg = approval.empty? ? @fp_operation.errors.full_messages : @fp_operation.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @fp_operation
  end

  private

  def fp_operation_params
    params.require(:fp_operation).permit(:operation_name, :lock_version, :approval_status, :last_action, :approved_version,
                                   :approved_id, :created_by, :updated_by)
  end
end
