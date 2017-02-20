require 'will_paginate/array'

class PartnerLcyRatesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include PartnerLcyRateHelper


  def create
    @partner_lcy_rate = PartnerLcyRate.new(params[:partner_lcy_rate])
    if !@partner_lcy_rate.valid?
      render "edit"
    else
      @partner_lcy_rate.created_by = current_user.id
      @partner_lcy_rate.save!

      flash[:alert] = 'Partner Lcy Rate successfully created and is pending for approval'
      redirect_to @partner_lcy_rate
    end
  end 

  def edit
    partner_lcy_rate = PartnerLcyRate.unscoped.find_by_id(params[:id])
    if partner_lcy_rate.approval_status == 'A' && partner_lcy_rate.unapproved_record.nil?
      params = (partner_lcy_rate.attributes).merge({:approved_id => partner_lcy_rate.id,:approved_version => partner_lcy_rate.lock_version})
      partner_lcy_rate = PartnerLcyRate.new(params)
    end
    @partner_lcy_rate = partner_lcy_rate   
  end

  def update
    @partner_lcy_rate = PartnerLcyRate.unscoped.find_by_id(params[:id])
    @partner_lcy_rate.attributes = params[:partner_lcy_rate]
    if !@partner_lcy_rate.valid?
      render "edit"
    else
      @partner_lcy_rate.updated_by = current_user.id
      @partner_lcy_rate.save!
      flash[:alert] = 'Partner Lcy Rate successfully modified and is pending for approval'
      redirect_to @partner_lcy_rate
    end
    rescue ActiveRecord::StaleObjectError
      @partner_lcy_rate.reload
      flash[:alert] = 'Someone edited the partner_lcy_rate the same time you did. Please re-apply your changes to the partner_lcy_rate.'
      render "edit"
  end 

  def show
    @partner_lcy_rate = PartnerLcyRate.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      partner_lcy_rates = find_partner_lcy_rates(params).order("id desc")
    else
      partner_lcy_rates = (params[:approval_status].present? and params[:approval_status] == 'U') ? PartnerLcyRate.unscoped.where("approval_status =?",'U').order("id desc") : PartnerLcyRate.order("id desc")
    end
    @partner_lcy_rates_count = partner_lcy_rates.count
    @partner_lcy_rates = partner_lcy_rates.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @partner_lcy_rate = PartnerLcyRate.unscoped.find(params[:id]) rescue nil
    @audit = @partner_lcy_rate.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    @partner_lcy_rate = PartnerLcyRate.unscoped.find(params[:id]) rescue nil
    PartnerLcyRate.transaction do
      approval = @partner_lcy_rate.approve
      if approval.empty?
        flash[:alert] = "Partner Lcy Rate record was approved successfully"
      else
        msg = @partner_lcy_rate.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @partner_lcy_rate
  end

  private

  def partner_lcy_rate_params
    params.require(:partner_lcy_rate).permit(:partner_code, :created_by, :updated_by, :approved_id, :approved_version, 
                                             :created_at, :updated_at, :lock_version, :rate, :approval_status)
  end
end