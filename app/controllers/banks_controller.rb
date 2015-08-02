require 'will_paginate/array'

class BanksController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(params[:bank])
    if !@bank.valid?
      render "new"
    else
      @bank.created_by = current_user.id
      @bank.save!
      flash[:alert] = 'Bank successfully created and is pending for approval'
      redirect_to @bank
    end
  end 

  def edit
    bank = Bank.unscoped.find_by_id(params[:id])
    if bank.approval_status == 'A' && bank.unapproved_record.nil?
      params = (bank.attributes).merge({:approved_id => bank.id,:approved_version => bank.lock_version})
      bank = Bank.new(params)
    end
    @bank = bank  
  end

  def update
    @bank = Bank.unscoped.find_by_id(params[:id])
    @bank.attributes = params[:bank]
    if !@bank.valid?
      render "edit"
    else
      @bank.updated_by = current_user.id
      @bank.save!
      flash[:alert] = 'Bank successfully modified and is pending for approval'
      redirect_to @bank
    end
    rescue ActiveRecord::StaleObjectError
      @bank.reload
      flash[:alert] = 'Someone edited the bank the same time you did. Please re-apply your changes to the bank.'
      render "edit"
  end 

  def show
    @bank = Bank.unscoped.find_by_id(params[:id])
  end

  def index
    banks = (params[:approval_status].present? and params[:approval_status] == 'U') ? Bank.unscoped.where("approval_status =?",'U').order("id desc") : Bank.order("id desc")
    @banks_count = banks.count
    @banks = banks.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @bank = Bank.unscoped.find(params[:id]) rescue nil
    @audit = @bank.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @bank = Bank.unscoped.find(params[:id]) rescue nil
    Bank.transaction do
      approval = @bank.approve
      if @bank.save and approval.empty?
        flash[:alert] = "Bank record was approved successfully"
      else
        msg = approval.empty? ? @bank.errors.full_messages : @bank.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @bank
  end

  private

  def bank_params
    params.require(:bank).permit(:ifsc,:name,:imps_enabled, :created_by, :updated_by, :lock_version,
                                 :approved_id, :approved_version)
  end
end
