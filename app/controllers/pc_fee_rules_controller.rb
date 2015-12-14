require 'will_paginate/array'

class PcFeeRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include PcFeeRulesHelper

  def new
    @pc_fee_rule = PcFeeRule.new
  end

  def create
    @pc_fee_rule = PcFeeRule.new(params[:pc_fee_rule])
    if !@pc_fee_rule.valid?
      render "new"
    else
      @pc_fee_rule.created_by = current_user.id
      @pc_fee_rule.save!
      flash[:alert] = 'PcFeeRule successfully created and is pending for approval'
      redirect_to @pc_fee_rule
    end
  end 

  def edit
    pc_fee_rule = PcFeeRule.unscoped.find_by_id(params[:id])
    if pc_fee_rule.approval_status == 'A' && pc_fee_rule.unapproved_record.nil?
      params = (pc_fee_rule.attributes).merge({:approved_id => pc_fee_rule.id,:approved_version => pc_fee_rule.lock_version})
      pc_fee_rule = PcFeeRule.new(params)
    end
    @pc_fee_rule = pc_fee_rule  
  end

  def update
    @pc_fee_rule = PcFeeRule.unscoped.find_by_id(params[:id])
    @pc_fee_rule.attributes = params[:pc_fee_rule]
    if !@pc_fee_rule.valid?
      render "edit"
    else
      @pc_fee_rule.updated_by = current_user.id
      @pc_fee_rule.save!
      flash[:alert] = 'PcFeeRule successfully modified and is pending for approval'
      redirect_to @pc_fee_rule
    end
    rescue ActiveRecord::StaleObjectError
      @pc_fee_rule.reload
      flash[:alert] = 'Someone edited the pc_fee_rule the same time you did. Please re-apply your changes to the pc_fee_rule.'
      render "edit"
  end 

  def show
    @pc_fee_rule = PcFeeRule.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      pc_fee_rules = find_pc_fee_rules(params).order("id desc")
    else
      pc_fee_rules = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcFeeRule.unscoped.where("approval_status =?",'U').order("id desc") : PcFeeRule.order("id desc")
    end
    @pc_fee_rules_count = pc_fee_rules.count
    @pc_fee_rules = pc_fee_rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @pc_fee_rule = PcFeeRule.unscoped.find(params[:id]) rescue nil
    @audit = @pc_fee_rule.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @pc_fee_rule = PcFeeRule.unscoped.find(params[:id]) rescue nil
    PcFeeRule.transaction do
      approval = @pc_fee_rule.approve
      if @pc_fee_rule.save and approval.empty?
        flash[:alert] = "PcFeeRule record was approved successfully"
      else
        msg = approval.empty? ? @pc_fee_rule.errors.full_messages : @pc_fee_rule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @pc_fee_rule
  end

  private

  def pc_fee_rule_params
    params.require(:pc_fee_rule).permit(:app_id, :txn_kind, :no_of_tiers, :tier1_to_amt, :tier1_method, 
                                        :tier1_fixed_amt, :tier1_pct_value, :tier1_min_sc_amt, :tier1_max_sc_amt,
                                        :tier2_to_amt, :tier2_method, :tier2_fixed_amt, :tier2_pct_value, :tier2_min_sc_amt, :tier2_max_sc_amt,
                                        :tier3_method, :tier3_fixed_amt, :tier3_pct_value, :tier3_min_sc_amt, :tier3_max_sc_amt,  
                                        :lock_version, :approval_status, :last_action, :approved_version, :approved_id, :created_by, :updated_by)
  end
end
