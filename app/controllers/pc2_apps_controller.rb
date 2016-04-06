require 'will_paginate/array'

class Pc2AppsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Pc2AppsHelper

  def new
    @pc2_app = Pc2App.new
  end

  def create
    @pc2_app = Pc2App.new(params[:pc2_app])
    if !@pc2_app.valid?
      render "new"
    else
      @pc2_app.created_by = current_user.id
      @pc2_app.save!
      flash[:alert] = 'Pc2App successfully created and is pending for approval'
      redirect_to @pc2_app
    end
  end 

  def edit
    pc2_app = Pc2App.unscoped.find_by_id(params[:id])
    if pc2_app.approval_status == 'A' && pc2_app.unapproved_record.nil?
      params = (pc2_app.attributes).merge({:approved_id => pc2_app.id,:approved_version => pc2_app.lock_version})
      pc2_app = Pc2App.new(params)
    end
    @pc2_app = pc2_app  
  end

  def update
    @pc2_app = Pc2App.unscoped.find_by_id(params[:id])
    @pc2_app.attributes = params[:pc2_app]
    if !@pc2_app.valid?
      render "edit"
    else
      @pc2_app.updated_by = current_user.id
      @pc2_app.save!
      flash[:alert] = 'Pc2App successfully modified and is pending for approval'
      redirect_to @pc2_app
    end
    rescue ActiveRecord::StaleObjectError
      @pc2_app.reload
      flash[:alert] = 'Someone edited the pc2_app the same time you did. Please re-apply your changes to the pc2_app.'
      render "edit"
  end 

  def show
    @pc2_app = Pc2App.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      pc2_apps = find_pc2_apps(params).order("id desc")
    else
      pc2_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? Pc2App.unscoped.where("approval_status =?",'U').order("id desc") : Pc2App.order("id desc")
    end
    @pc2_apps_count = pc2_apps.count
    @pc2_apps = pc2_apps.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @pc2_app = Pc2App.unscoped.find(params[:id]) rescue nil
    @audit = @pc2_app.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @pc2_app = Pc2App.unscoped.find(params[:id]) rescue nil
    Pc2App.transaction do
      approval = @pc2_app.approve
      if @pc2_app.save and approval.empty?
        flash[:alert] = "Pc2App record was approved successfully"
      else
        msg = approval.empty? ? @pc2_app.errors.full_messages : @pc2_app.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @pc2_app
  end

  private

  def pc2_app_params
    params.require(:pc2_app).permit(:app_id, :customer_id, :is_enabled, :identity_user_id, :lock_version, :approval_status, :last_action, :approved_version,
                                   :approved_id, :created_by, :updated_by)
  end
end
