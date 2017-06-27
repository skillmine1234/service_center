class ImtRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def edit
    imt_rule = ImtRule.unscoped.find_by_id(params[:id])
    if imt_rule.approval_status == 'A' && imt_rule.unapproved_record.nil?
      params = (imt_rule.attributes).merge({:approved_id => imt_rule.id, :approved_version => imt_rule.lock_version})
      imt_rule = ImtRule.new(params)
    end
    @imt_rule = imt_rule
  end

  def update
    @imt_rule = ImtRule.unscoped.find_by_id(params[:id])
    @imt_rule.attributes = params[:imt_rule]
    if !@imt_rule.valid?
      render "edit"
    else
      @imt_rule.updated_by = current_user.id
      @imt_rule.save
      flash[:alert] = 'Rule successfuly modified and is pending for approval'
      redirect_to @imt_rule
    end
  rescue ActiveRecord::StaleObjectError
    @imt_rule.reload
    flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
    render "edit"
  end

  def index
    imt_rules = ImtRule.unscoped.where("approval_status=?",'U').order("id desc")
    @imt_rules_count = imt_rules.count
    @imt_rules = imt_rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @imt_rule = ImtRule.unscoped.find_by_id(params[:id])
  end

  def audit_logs
    @record = ImtRule.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end

  def approve
    @imt_rule = ImtRule.unscoped.find(params[:id]) rescue nil
    ImtRule.transaction do
      approval = @imt_rule.approve
      if @imt_rule.save and approval.empty?
        flash[:alert] = "IMT Rule record was approved successfully"
      else
        msg = approval.empty? ? @imt_rule.errors.full_messages : @imt_rule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @imt_rule
  end

  private

  def imt_rule_params
    params.require(:imt_rule).permit(:stl_gl_account, :chargeback_gl_account, :lock_version, :last_action, :approval_status, :approved_version, :approved_id)
  end

end