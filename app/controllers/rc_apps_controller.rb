class RcAppsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

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
    params.require(:rc_app).permit(:lock_version, :last_action, :updated_by, :url, :http_username, :http_password, 
    :setting1_value, :setting2_value)
  end
end
