require 'will_paginate/array'

class InwGuidelinesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  # include InwGuidelineHelper

  def new
    @inw_guideline = InwGuideline.new
  end

  def create
    @inw_guideline = InwGuideline.new(params[:inw_guideline])
    if !@inw_guideline.valid?
      render "new"
    else
      @inw_guideline.created_by = current_user.id
      @inw_guideline.save!

      flash[:alert] = 'InwGuideline successfully created and is pending for approval'
      redirect_to @inw_guideline
    end
  end 

  def edit
    inw_guideline = InwGuideline.unscoped.find_by_id(params[:id])
    if inw_guideline.approval_status == 'A' && inw_guideline.unapproved_record.nil?
      params = (inw_guideline.attributes).merge({:approved_id => inw_guideline.id,:approved_version => inw_guideline.lock_version})
      inw_guideline = InwGuideline.new(params)
    end
    @inw_guideline = inw_guideline   
  end

  def update
    @inw_guideline = InwGuideline.unscoped.find_by_id(params[:id])
    @inw_guideline.attributes = params[:inw_guideline]
    if !@inw_guideline.valid?
      render "edit"
    else
      @inw_guideline.updated_by = current_user.id
      @inw_guideline.save!
      flash[:alert] = 'InwGuideline successfully modified and is pending for approval'
      redirect_to @inw_guideline
    end
    rescue ActiveRecord::StaleObjectError
      @inw_guideline.reload
      flash[:alert] = 'Someone edited the inw_guideline the same time you did. Please re-apply your changes to the inw_guideline.'
      render "edit"
  end 

  def show
    @inw_guideline = InwGuideline.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      inw_guidelines = find_inw_guidelines(params).order("id desc")
    else
      inw_guidelines = (params[:approval_status].present? and params[:approval_status] == 'U') ? InwGuideline.unscoped.where("approval_status =?",'U').order("id desc") : InwGuideline.order("id desc")
    end
    @inw_guidelines_count = inw_guidelines.count
    @inw_guidelines = inw_guidelines.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @inw_guideline = InwGuideline.unscoped.find(params[:id]) rescue nil
    @audit = @inw_guideline.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    @inw_guideline = InwGuideline.unscoped.find(params[:id]) rescue nil
    InwGuideline.transaction do
      approval = @inw_guideline.approve
      if @inw_guideline.save and approval.empty?
        flash[:alert] = "InwGuideline record was approved successfully"
      else
        msg = approval.empty? ? @inw_guideline.errors.full_messages : @inw_guideline.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @inw_guideline
  end

  private

  def inw_guideline_params
    params.require(:inw_guideline).permit(:code, :allow_neft, :allow_imps, :allow_rtgs, :ytd_txn_cnt_bene, :disallowed_products,
                                          :needs_lcy_rate, :lock_version, :approval_status, :approved_id, :approved_version)
  end
end