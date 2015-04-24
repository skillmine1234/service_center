require 'will_paginate/array'

class PartnersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

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
      flash[:alert] = 'Partner successfuly created'
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
      flash[:alert] = 'Partner successfuly modified'
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
    partners = Partner.order("id desc")
    @partners_count = partners.count
    @partners = partners.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @partner = Partner.find(params[:id]) rescue nil
    @audit = @partner.audits[params[:version_id].to_i] rescue nil
  end
end

