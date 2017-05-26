class NsCallbacksController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Approval2::ControllerAdditions

  def create
    @ns_callback = NsCallback.new(params[:ns_callback])
    if !@ns_callback.valid?
      render "edit"
    else
      @ns_callback.created_by = current_user.id
      @ns_callback.save!
      flash[:alert] = 'Callback record successfully created and is pending for approval'
      redirect_to @ns_callback
    end
  end

  def update
    @ns_callback = NsCallback.unscoped.find_by_id(params[:id])
    @ns_callback.attributes = params[:ns_callback]
    if !@ns_callback.valid?
      render "edit"
    else
      @ns_callback.updated_by = current_user.id
      @ns_callback.save!
      flash[:alert] = 'Callback record successfully modified successfully'
      redirect_to @ns_callback
    end
    rescue ActiveRecord::StaleObjectError
      @ns_callback.reload
      flash[:alert] = 'Someone edited the ns_callback the same time you did. Please re-apply your changes to the ns_callback.'
      render "edit"
  end 

  def show
    @ns_callback = NsCallback.unscoped.find_by_id(params[:id])
  end

  def index
    @ns_callbacks ||= NsCallback.order("id desc").paginate(:per_page => 10, :page => params[:page])
  end
  
  def audit_logs
    @record = NsCallback.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'ns')
  end

  private

  def ns_callback_params
    params.require(:ns_callback).permit(:lock_version, :last_action, :updated_by, :notify_url, :http_username, :http_password, 
    :settings_cnt, :udfs_cnt, :unique_udfs_cnt, 
    :setting1_name, :setting1_type, :setting1_value, 
    :setting2_name, :setting2_type, :setting2_value, 
    :setting3_name, :setting3_type, :setting3_value, 
    :setting4_name, :setting4_type, :setting4_value,
    :setting5_name, :setting5_type, :setting5_value,
    :udf1_name, :udf1_type, 
    :udf2_name, :udf2_type, 
    :udf3_name, :udf3_type, 
    :udf4_name, :udf4_type,
    :udf5_name, :udf5_type,
    :app_code, :approval_status, :approved_version, :approved_id)
  end
end
