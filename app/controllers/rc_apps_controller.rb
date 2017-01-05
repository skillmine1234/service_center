class RcAppsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  # include RcAppsHelper
  
  def new
    @rc_app = RcApp.new
  end

  def create
    @rc_app = RcApp.new(params[:rc_app])
    if !@rc_app.valid?
      render "new"
    else
      @rc_app.created_by = current_user.id
      @rc_app.save!
      flash[:alert] = 'Rc App successfully created successfully'
      redirect_to @rc_app
    end
  end 

  def edit
    @rc_app = RcApp.unscoped.find_by_id(params[:id])  
  end

  def update
    @rc_app = RcApp.unscoped.find_by_id(params[:id])
    @rc_app.attributes = params[:rc_app]
    if !@rc_app.valid?
      render "edit"
    else
      @rc_app.updated_by = current_user.id
      @rc_app.save!
      flash[:alert] = 'Rc App successfully modified successfully'
      redirect_to @rc_app
    end
    rescue ActiveRecord::StaleObjectError
      @rc_app.reload
      flash[:alert] = 'Someone edited the rc_app the same time you did. Please re-apply your changes to the rc_app.'
      render "edit"
  end 

  def show
    @rc_app = RcApp.unscoped.find_by_id(params[:id])
    respond_to do |format|
      format.json { render json: @rc_app }
      format.html 
    end 
  end

  def index
    rc_apps = RcApp.unscoped.order("id desc")
    @rc_apps_count = rc_apps.count
    @rc_apps = rc_apps.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def audit_logs
    @rc_app = RcApp.unscoped.find(params[:id]) rescue nil
    @audit = @rc_app.audits[params[:version_id].to_i] rescue nil
  end
  
  private

  def rc_app_params
    params.require(:rc_app).permit(:app_id, :udfs_cnt, :udf1_name, :udf1_type, :udf1_is_mandatory, :udf2_name, :udf2_type, :udf2_is_mandatory, 
    :udf3_name, :udf3_type, :udf3_is_mandatory, :udf4_name, :udf4_type, :udf4_is_mandatory, :udf5_name, :udf5_type, :udf5_is_mandatory, 
    :lock_version, :last_action, :created_by, :updated_by)
  end
end
