class EcolAppsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Approval2::ControllerAdditions

  def create
    @ecol_app = EcolApp.new(params[:ecol_app])
    if !@ecol_app.valid?
      render "edit"
    else
      @ecol_app.created_by = current_user.id
      @ecol_app.save!
      flash[:alert] = 'Ecol App successfully created and is pending for approval'
      redirect_to @ecol_app
    end
  end

  def update
    @ecol_app = EcolApp.unscoped.find_by_id(params[:id])
    @ecol_app.attributes = params[:ecol_app]
    if !@ecol_app.valid?
      render "edit"
    else
      @ecol_app.updated_by = current_user.id
      @ecol_app.save!
      flash[:alert] = 'Ecol App successfully modified successfully'
      redirect_to @ecol_app
    end
    rescue ActiveRecord::StaleObjectError
      @ecol_app.reload
      flash[:alert] = 'Someone edited the ecol_app the same time you did. Please re-apply your changes to the ecol_app.'
      render "edit"
  end 

  def show
    @ecol_app = EcolApp.unscoped.find_by_id(params[:id])
  end

  def index
    ecol_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? EcolApp.unscoped.where("approval_status =?",'U').order("id desc") : EcolApp.order("id desc")
    @ecol_apps_count = ecol_apps.count
    @ecol_apps = ecol_apps.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def audit_logs
    @ecol_app = EcolApp.unscoped.find(params[:id]) rescue nil
    @audit = @ecol_app.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'e-collect')
  end
  
  def ecol_app_udtables
    @ecol_app = EcolApp.find_by(app_code: params[:app_code])
    if params[:approval_status].present?
      @records = EcolAppUdtable.unscoped.where(app_code: params[:app_code], approval_status: params[:approval_status])
    else
      @records = @ecol_app.ecol_app_udtables
    end
    render 'ecol_app_udtables/grouped_index'
  end

  private

  def ecol_app_params
    params.require(:ecol_app).permit(:lock_version, :last_action, :updated_by, :notify_url, :validate_url, :http_username, :http_password, 
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
