class FpAuthRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include FpAuthRulesHelper

  def new
    @fp_auth_rule = FpAuthRule.new
  end

  def create
    @fp_auth_rule = FpAuthRule.new(params[:fp_auth_rule])
    if !@fp_auth_rule.valid?
      render "new"
    else
      @fp_auth_rule.created_by = current_user.id
      @fp_auth_rule.save!
      flash[:alert] = 'Authorisation Rule successfully created and is pending for approval'
      redirect_to @fp_auth_rule
    end
  end 

  def edit
    fp_auth_rule = FpAuthRule.unscoped.find_by_id(params[:id])
    if fp_auth_rule.approval_status == 'A' && fp_auth_rule.unapproved_record.nil?
      params = (fp_auth_rule.attributes).merge({:approved_id => fp_auth_rule.id,:approved_version => fp_auth_rule.lock_version})
      fp_auth_rule = FpAuthRule.new(params)
    end
    @fp_auth_rule = fp_auth_rule  
  end

  def update
    @fp_auth_rule = FpAuthRule.unscoped.find_by_id(params[:id])
    @fp_auth_rule.attributes = params[:fp_auth_rule]
    if !@fp_auth_rule.valid?
      render "edit"
    else
      @fp_auth_rule.updated_by = current_user.id
      @fp_auth_rule.save!
      flash[:alert] = 'Authorisation Rule successfully modified and is pending for approval'
      redirect_to @fp_auth_rule
    end
    rescue ActiveRecord::StaleObjectError
      @fp_auth_rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 

  def show
    @fp_auth_rule = FpAuthRule.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      fp_auth_rules = find_fp_auth_rules(params).order("id desc")
    else
      fp_auth_rules = (params[:approval_status].present? and params[:approval_status] == 'U') ? FpAuthRule.unscoped.where("approval_status =?",'U').order("id desc") : FpAuthRule.order("id desc")
    end
    @fp_auth_rules_count = fp_auth_rules.count
    @fp_auth_rules = fp_auth_rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @fp_auth_rule = FpAuthRule.unscoped.find(params[:id]) rescue nil
    @audit = @fp_auth_rule.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @fp_auth_rule = FpAuthRule.unscoped.find(params[:id]) rescue nil
    FpAuthRule.transaction do
      approval = @fp_auth_rule.approve
      if @fp_auth_rule.save and approval.empty?
        flash[:alert] = "Authorisation Rule was approved successfully"
      else
        msg = approval.empty? ? @fp_auth_rule.errors.full_messages : @fp_auth_rule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @fp_auth_rule
  end

  private

  def fp_auth_rule_params
    params.require(:fp_auth_rule).permit(:username, :operation_name, :is_enabled, :lock_version, :approval_status, :last_action, :approved_version,
                                   :approved_id, :created_by, :updated_by)
  end
end
