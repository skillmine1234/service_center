require 'will_paginate/array'

class RulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(params[:rule])
    if !@rule.valid?
      render "new"
    else
      @rule.created_by = current_user.id
      @rule.save
      flash[:alert] = 'Rule successfuly created'
      redirect_to @rule
    end
  end 

  def edit
    @rule = Rule.find_by_id(params[:id])
  end

  def update
    @rule = Rule.find_by_id(params[:id])
    @rule.attributes = params[:rule]
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
    @rule = Rule.find_by_id(params[:id])
  end

  def index
    rules = Rule.order("id desc")
    @rules_count = rules.count
    @rules = rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @rule = Rule.find(params[:id]) rescue nil
    @audit = @rule.audits[params[:version_id].to_i] rescue nil
  end

  private

  def rule_params
    params.require(:rule).permit(:pattern_individuals, :pattern_corporates, :pattern_beneficiaries, :created_by, 
                                 :updated_by, :lock_version)
  end
end

