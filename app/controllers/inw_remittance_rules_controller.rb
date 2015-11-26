require 'will_paginate/array'

class InwRemittanceRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def new
    @rule = InwRemittanceRule.new
  end

  def create
    @rule = InwRemittanceRule.new(params[:inw_remittance_rule])
    if !@rule.valid?
      render "new"
    else
      @rule.created_by = current_user.id
      @rule.save
      flash[:alert] = 'Rule successfully created and is pending for approval'
      redirect_to @rule
    end
  end

  def edit
    rule = InwRemittanceRule.unscoped.find_by_id(params[:id])
    if rule.approval_status == 'A' && rule.unapproved_record.nil?
      params = (rule.attributes).merge({:approved_id => rule.id,:approved_version => rule.lock_version})
      rule = InwRemittanceRule.new(params)     
    end
    @rule = rule 
  end

  def update
    @rule = InwRemittanceRule.unscoped.find_by_id(params[:id])
    @rule.attributes = params[:inw_remittance_rule]
    if !@rule.valid?
      render "edit"
    else
      @rule.updated_by = current_user.id
      @rule.save
      flash[:alert] = 'Rule successfully modified and is pending for approval'
      redirect_to @rule
    end
    rescue ActiveRecord::StaleObjectError
      @rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 
  
  def index
    rules = InwRemittanceRule.unscoped.where("approval_status=?",'U').order("id desc")
    @rules_count = rules.count
    @rules = rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @rule = InwRemittanceRule.unscoped.find_by_id(params[:id])
  end

  def audit_logs
    @rule = InwRemittanceRule.unscoped.find(params[:id]) rescue nil
    @audit = @rule.audits[params[:version_id].to_i] rescue nil
  end

  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end
  
  def approve
    @rule = InwRemittanceRule.unscoped.find(params[:id]) rescue nil
    InwRemittanceRule.transaction do
      approval = @rule.approve
      if (@rule.destroyed? || @rule.save) and approval.empty?
        flash[:alert] = "Rule record was approved successfully"
      else
        msg = approval.empty? ? @rule.errors.full_messages : @rule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @rule
  end

  private

  def inw_remittance_rule_params
    params.require(:inw_remittance_rule).permit(:pattern_individuals, :pattern_corporates, :pattern_beneficiaries, :created_by, 
                                 :updated_by, :lock_version, :pattern_salutations, :pattern_remitters, :approved_id, :approved_version)
  end
end