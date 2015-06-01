require 'will_paginate/array'

class InwRemittanceRulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def edit
    @rule = InwRemittanceRule.find_by_id(params[:id])
  end

  def update
    @rule = InwRemittanceRule.find_by_id(params[:id])
    @rule.attributes = params[:inw_remittance_rule]
    if !@rule.valid?
      render "edit"
    else
      @rule.updated_by = current_user.id
      @rule.save
      flash[:alert] = 'Rule successfuly modified'
      redirect_to @rule
    end
    rescue ActiveRecord::StaleObjectError
      @rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 

  def show
    @rule = InwRemittanceRule.find_by_id(params[:id])
  end

  def audit_logs
    @rule = InwRemittanceRule.find(params[:id]) rescue nil
    @audit = @rule.audits[params[:version_id].to_i] rescue nil
  end

  private

  def inw_remittance_rule_params
    params.require(:inw_remittance_rule).permit(:pattern_individuals, :pattern_corporates, :pattern_beneficiaries, :created_by, 
                                 :updated_by, :lock_version, :pattern_salutations)
  end
end

