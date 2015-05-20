require 'will_paginate/array'

class BanksController < ApplicationController
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
      @bank.save
      flash[:alert] = 'Bank successfuly created'
      redirect_to @bank
    end
  end 

  def edit
    @bank = Bank.find_by_id(params[:id])
  end

  def update
    @bank = Bank.find_by_id(params[:id])
    @bank.attributes = params[:bank]
    if !@bank.valid?
      render "edit"
    else
      @bank.updated_by = current_user.id
      @bank.save
      flash[:alert] = 'Bank successfuly modified'
      redirect_to @bank
    end
    rescue ActiveRecord::StaleObjectError
      @bank.reload
      flash[:alert] = 'Someone edited the bank the same time you did. Please re-apply your changes to the bank.'
      render "edit"
  end 

  def show
    @bank = Bank.find_by_id(params[:id])
  end

  def index
    banks = Bank.order("id desc")
    @banks_count = banks.count
    @banks = banks.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @bank = Bank.find(params[:id]) rescue nil
    @audit = @bank.audits[params[:version_id].to_i] rescue nil
  end

  private

  def bank_params
    params.require(:bank).permit(:ifsc,:name,:imps_enabled, :created_by, :updated_by, :lock_version)
  end
end

