require 'will_paginate/array'

class PartnersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include PartnerHelper

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(params[:partner])
    if !@partner.valid?
      render "new"
    else
      @partner.created_by = current_user.id
      @partner.save

      flash[:alert] = 'Partner successfully created'
      redirect_to @partner
    end
  end 

  def edit
    @partner = Partner.find_by_id(params[:id])
  end

  def update
    @partner = Partner.find_by_id(params[:id])
    @partner.attributes = params[:partner]
    if !@partner.valid?
      render "edit"
    else
      @partner.updated_by = current_user.id
      @partner.save
      flash[:alert] = 'Partner successfully modified'
      redirect_to @partner
    end
    rescue ActiveRecord::StaleObjectError
      @partner.reload
      flash[:alert] = 'Someone edited the partner the same time you did. Please re-apply your changes to the partner.'
      render "edit"
  end 

  def show
    @partner = Partner.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      partners = find_partners(params).order("id desc")
    else
      partners = Partner.order("id desc")
    end
    @partners_count = partners.count
    @partners = partners.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @partner = Partner.find(params[:id]) rescue nil
    @audit = @partner.audits[params[:version_id].to_i] rescue nil
  end

  private

  def partner_params
    params.require(:partner).permit(:account_ifsc, :account_no, :allow_imps, :allow_neft, :allow_rtgs, 
                                    :beneficiary_email_allowed, :beneficiary_sms_allowed, :code, :created_by, 
                                    :identity_user_id, :low_balance_alert_at, :name, :ops_email_id, 
                                    :remitter_email_allowed, :remitter_sms_allowed, :tech_email_id, 
                                    :txn_hold_period_days, :updated_by, :lock_version, :enabled, :customer_id,
                                    :country, :address_line1, :address_line2, :address_line3,:mmid, :mobile_no)
  end
end

