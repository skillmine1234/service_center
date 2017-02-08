class EcolAppsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

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
  
  def edit
    ecol_app = EcolApp.unscoped.find_by_id(params[:id])
    if ecol_app.approval_status == 'A' && ecol_app.unapproved_record.nil?
      params = (ecol_app.attributes).merge({:approved_id => ecol_app.id,:approved_version => ecol_app.lock_version, :app_code => ecol_app.app_code, :settings_cnt => ecol_app.settings_cnt})
      ecol_app = EcolApp.new(params)
    end
    @ecol_app = ecol_app
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
    @ecol_app = EcolApp.unscoped.find(params[:id]) rescue nil
    EcolApp.transaction do
      approval = @ecol_app.approve
      if approval.empty?
        flash[:alert] = "Ecol App record was approved successfully"
      else
        msg = @ecol_app.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @ecol_app
  end

  private

  def ecol_app_params
    params.require(:ecol_app).permit(:lock_version, :last_action, :updated_by, :notify_url, :validate_url, 
    :http_username, :http_password, :settings_cnt, :use_proxy,
    :setting1_name, :setting1_type, :setting1_value, 
    :setting2_name, :setting2_type, :setting2_value, 
    :setting3_name, :setting3_type, :setting3_value, 
    :setting4_name, :setting4_type, :setting4_value,
    :setting5_name, :setting5_type, :setting5_value,
    :app_code, :approval_status, :approved_version, :approved_id)
  end
end
