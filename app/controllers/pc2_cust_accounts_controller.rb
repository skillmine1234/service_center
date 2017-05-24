require 'will_paginate/array'

class Pc2CustAccountsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Pc2CustAccountsHelper

  def new
    @pc2_cust_account = Pc2CustAccount.new
  end

  def create
    @pc2_cust_account = Pc2CustAccount.new(params[:pc2_cust_account])
    if !@pc2_cust_account.valid?
      render "new"
    else
      @pc2_cust_account.created_by = current_user.id
      @pc2_cust_account.save!
      flash[:alert] = 'Customer Account successfully created and is pending for approval'
      redirect_to @pc2_cust_account
    end
  end 

  def edit
    pc2_cust_account = Pc2CustAccount.unscoped.find_by_id(params[:id])
    if pc2_cust_account.approval_status == 'A' && pc2_cust_account.unapproved_record.nil?
      params = (pc2_cust_account.attributes).merge({:approved_id => pc2_cust_account.id,:approved_version => pc2_cust_account.lock_version})
      pc2_cust_account = Pc2CustAccount.new(params)
    end
    @pc2_cust_account = pc2_cust_account  
  end

  def update
    @pc2_cust_account = Pc2CustAccount.unscoped.find_by_id(params[:id])
    @pc2_cust_account.attributes = params[:pc2_cust_account]
    if !@pc2_cust_account.valid?
      render "edit"
    else
      @pc2_cust_account.updated_by = current_user.id
      @pc2_cust_account.save!
      flash[:alert] = 'Customer Account successfully modified and is pending for approval'
      redirect_to @pc2_cust_account
    end
    rescue ActiveRecord::StaleObjectError
      @pc2_cust_account.reload
      flash[:alert] = 'Someone edited the Customer Account the same time you did. Please re-apply your changes to the Customer.'
      render "edit"
  end 

  def show
    @pc2_cust_account = Pc2CustAccount.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      pc2_cust_accounts = find_pc2_cust_accounts(params).order("id desc")
    else
      pc2_cust_accounts = (params[:approval_status].present? and params[:approval_status] == 'U') ? Pc2CustAccount.unscoped.where("approval_status =?",'U').order("id desc") : Pc2CustAccount.order("id desc")
    end
    @pc2_cust_accounts_count = pc2_cust_accounts.count
    @pc2_cust_accounts = pc2_cust_accounts.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @record = Pc2CustAccount.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @pc2_cust_account = Pc2CustAccount.unscoped.find(params[:id]) rescue nil
    Pc2CustAccount.transaction do
      approval = @pc2_cust_account.approve
      if @pc2_cust_account.save and approval.empty?
        flash[:alert] = "Customer Account record was approved successfully"
      else
        msg = approval.empty? ? @pc2_cust_account.errors.full_messages : @pc2_cust_account.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @pc2_cust_account
  end

  private

  def pc2_cust_account_params
    params.require(:pc2_cust_account).permit(:customer_id, :account_no, :is_enabled, :lock_version, :approval_status, :last_action, :approved_version, :approved_id, :created_by, :updated_by)
  end
end
