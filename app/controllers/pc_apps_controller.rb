require 'will_paginate/array'

class PcAppsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include PcAppsHelper

  def new
    @pc_app = PcApp.new
  end

  def create
    @pc_app = PcApp.new(params[:pc_app])
    if !@pc_app.valid?
      render "new"
    else
      @pc_app.created_by = current_user.id
      @pc_app.save!
      flash[:alert] = 'PcApp successfully created and is pending for approval'
      redirect_to @pc_app
    end
  end 

  def edit
    pc_app = PcApp.unscoped.find_by_id(params[:id])
    if pc_app.approval_status == 'A' && pc_app.unapproved_record.nil?
      params = (pc_app.attributes).merge({:approved_id => pc_app.id,:approved_version => pc_app.lock_version})
      pc_app = PcApp.new(params)
    end
    @pc_app = pc_app  
  end

  def update
    @pc_app = PcApp.unscoped.find_by_id(params[:id])
    @pc_app.attributes = params[:pc_app]
    if !@pc_app.valid?
      render "edit"
    else
      @pc_app.updated_by = current_user.id
      @pc_app.save!
      flash[:alert] = 'PcApp successfully modified and is pending for approval'
      redirect_to @pc_app
    end
    rescue ActiveRecord::StaleObjectError
      @pc_app.reload
      flash[:alert] = 'Someone edited the pc_app the same time you did. Please re-apply your changes to the pc_app.'
      render "edit"
  end 

  def show
    @pc_app = PcApp.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      pc_apps = find_pc_apps(params).order("id desc")
    else
      pc_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcApp.unscoped.where("approval_status =?",'U').order("id desc") : PcApp.order("id desc")
    end
    @pc_apps_count = pc_apps.count
    @pc_apps = pc_apps.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @pc_app = PcApp.unscoped.find(params[:id]) rescue nil
    @audit = @pc_app.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @pc_app = PcApp.unscoped.find(params[:id]) rescue nil
    PcApp.transaction do
      approval = @pc_app.approve
      if @pc_app.save and approval.empty?
        flash[:alert] = "PcApp record was approved successfully"
      else
        msg = approval.empty? ? @pc_app.errors.full_messages : @pc_app.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @pc_app
  end

  private

  def pc_app_params
    params.require(:pc_app).permit(:app_id, :card_acct, :sc_gl_income, :card_cust_id, :is_enabled, :lock_version, :approval_status, :last_action, :approved_version,
                                   :approved_id, :created_by, :updated_by, :traceid_prefix, :source_id, :channel_id, :needs_pin)
  end
end
