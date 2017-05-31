class RcTransferSchedulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include RcTransferSchedulesHelper
  
  def new
    @rc_transfer_schedule = RcTransferSchedule.new
  end
  
  def create
    @rc_transfer_schedule = RcTransferSchedule.new(params[:rc_transfer_schedule])
    if !@rc_transfer_schedule.valid?
      render "new"
    else
      @rc_transfer_schedule.created_by = current_user.id
      @rc_transfer_schedule.save!
      flash[:alert] = 'Rc Transfer Schedule successfully created and is pending for approval'
      redirect_to @rc_transfer_schedule
    end
  end
  
  def edit
    rc_transfer_schedule = RcTransferSchedule.unscoped.find_by_id(params[:id])
    if rc_transfer_schedule.approval_status == 'A' && rc_transfer_schedule.unapproved_record.nil?
      params = (rc_transfer_schedule.attributes).merge({:approved_id => rc_transfer_schedule.id,:approved_version => rc_transfer_schedule.lock_version})
      rc_transfer_schedule = RcTransferSchedule.new(params)
    end
    @rc_transfer_schedule = rc_transfer_schedule
  end
  
  def update
    @rc_transfer_schedule = RcTransferSchedule.unscoped.find_by_id(params[:id])
    @rc_transfer_schedule.attributes = params[:rc_transfer_schedule]
    if !@rc_transfer_schedule.valid?
      render "edit"
    else
      @rc_transfer_schedule.updated_by = current_user.id
      @rc_transfer_schedule.save!
      flash[:alert] = 'Rc Transfer Schedule successfully modified and is pending for approval'
      redirect_to @rc_transfer_schedule
    end
    rescue ActiveRecord::StaleObjectError
      @rc_transfer_schedule.reload
      flash[:alert] = 'Someone edited the Rc Transfer Schedule the same time you did. Please re-apply your changes to the Rc Transfer Schedule.'
      render "edit"
  end
  
  def show
    @rc_transfer_schedule = RcTransferSchedule.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      rc_transfer_schedules = find_rc_transfer_schedules(params).order("id desc")
    else
      rc_transfer_schedules = (params[:approval_status].present? and params[:approval_status] == 'U') ? RcTransferSchedule.unscoped.where("approval_status =?",'U').order("id desc") : RcTransferSchedule.order("id desc")
    end
    @rc_transfer_schedules_count = rc_transfer_schedules.count
    @rc_transfer_schedules = rc_transfer_schedules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def udfs
    @rc_app = RcApp.find_by_id(params[:rc_app_id])
    respond_to do |format|
      format.js
    end     
  end
  
  def audit_logs
    @rc_transfer_schedule = RcTransferSchedule.unscoped.find(params[:id]) rescue nil
    @audit = @rc_transfer_schedule.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @rc_transfer_schedule = RcTransferSchedule.unscoped.find(params[:id]) rescue nil
    RcTransferSchedule.transaction do
      approval = @rc_transfer_schedule.approve
      if @rc_transfer_schedule.save and approval.empty?
        flash[:alert] = "Rc Transfer Schedule record was approved successfully"
      else
        msg = approval.empty? ? @rc_transfer_schedule.errors.full_messages : @rc_transfer_schedule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @rc_transfer_schedule
  end
  
  def destroy
    rc_transfer_schedule = RcTransferSchedule.unscoped.find_by_id(params[:id])
    if rc_transfer_schedule.approval_status == 'U' and (current_user == rc_transfer_schedule.created_user or (can? :approve, rc_transfer_schedule))
      rc_transfer_schedule = rc_transfer_schedule.destroy
      flash[:alert] = "Rc Transfer Schedule record has been deleted!"
      redirect_to rc_transfer_schedules_path(:approval_status => 'U')
    else
      flash[:alert] = "You cannot delete this record!"
      redirect_to rc_transfer_schedules_path(:approval_status => 'U')
    end
  end

  private

  def rc_transfer_schedule_params
    params.require(:rc_transfer_schedule).permit(:code, :debit_account_no, :bene_account_no, :next_run_at, :last_run_at, :is_enabled, 
    :last_batch_no, :notify_mobile_no, :created_by, :updated_by, :lock_version, :approval_status, :last_action, :approved_version, :approved_id, :rc_app_id,
    :udf1_name, :udf1_type, :udf1_value,
    :udf2_name, :udf2_type, :udf2_value, 
    :udf3_name, :udf3_type, :udf3_value, 
    :udf4_name, :udf4_type, :udf4_value, 
    :udf5_name, :udf5_type, :udf5_value,
    :txn_kind, :interval_in_mins, :acct_threshold_amt, :bene_account_ifsc, :max_retries, :retry_in_mins, :interval_unit, :bene_name)
  end
end
