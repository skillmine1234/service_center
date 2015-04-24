require 'will_paginate/array'

class PurposeCodesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def new
    @purpose_code = PurposeCode.new
  end

  def create
    @purpose_code = PurposeCode.new(params[:purpose_code])
    if !@purpose_code.valid?
      render "new"
    else
      @purpose_code.created_by = current_user.id
      @purpose_code.save
      flash[:alert] = 'Purpose Code successfuly created'
      redirect_to @purpose_code
    end
  end 

  def edit
    @purpose_code = PurposeCode.find_by_id(params[:id])
  end

  def update
    @purpose_code = PurposeCode.find_by_id(params[:id])
    @purpose_code.attributes = params[:purpose_code]
    if !@purpose_code.valid?
      render "edit"
    else
      @purpose_code.updated_by = current_user.id
      @purpose_code.save
      flash[:alert] = 'Purpose Code successfuly modified'
      redirect_to @purpose_code
    end
    rescue ActiveRecord::StaleObjectError
      @purpose_code.reload
      flash[:alert] = 'Someone edited the purpose_code the same time you did. Please re-apply your changes to the purpose_code.'
      render "edit"
  end 

  def show
    @purpose_code = PurposeCode.find_by_id(params[:id])
  end

  def index
    purpose_codes = PurposeCode.order("id desc")
    @purpose_codes_count = purpose_codes.count
    @purpose_codes = purpose_codes.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @purpose_code = PurposeCode.find(params[:id]) rescue nil
    @audit = @purpose_code.audits[params[:version_id].to_i] rescue nil
  end
end

