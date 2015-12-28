class BmRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def new
    @bm_rule = BmRule.new
  end

  def create
    @bm_rule = BmRule.new(params[:bm_rule])
    if !@bm_rule.valid?
      render "new"
    else
      @bm_rule.created_by = current_user.id
      @bm_rule.save
      flash[:alert] = 'Rule successfully created and is pending for approval'
      redirect_to @bm_rule
    end
  end

  def edit
    bm_rule = BmRule.unscoped.find_by_id(params[:id])
    if bm_rule.approval_status == 'A' && bm_rule.unapproved_record.nil?
      params = (bm_rule.attributes).merge({:approved_id => bm_rule.id, :approved_version => bm_rule.lock_version})
      bm_rule = BmRule.new(params)
    end
    @bm_rule = bm_rule
  end

  def update
    @bm_rule = BmRule.unscoped.find_by_id(params[:id])
    @bm_rule.attributes = params[:bm_rule]
    if !@bm_rule.valid?
      render "edit"
    else
      @bm_rule.updated_by = current_user.id
      @bm_rule.save
      flash[:alert] = 'Rule successfuly modified and is pending for approval'
      redirect_to @bm_rule
    end
  rescue ActiveRecord::StaleObjectError
    @bm_rule.reload
    flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
    render "edit"
  end

  def index
    bm_rules = BmRule.unscoped.where("approval_status=?",'U').order("id desc")
    @bm_rules_count = bm_rules.count
    @bm_rules = bm_rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @bm_rule = BmRule.unscoped.find_by_id(params[:id])
  end

  def audit_logs
    @bm_rule = BmRule.unscoped.find(params[:id]) rescue nil
    @audit = @bm_rule.audits[params[:version_id].to_i] rescue nil
  end

  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end

  def approve
    @bm_rule = BmRule.unscoped.find(params[:id]) rescue nil
    BmRule.transaction do
      approval = @bm_rule.approve
      if @bm_rule.save and approval.empty?
        flash[:alert] = "Bm Rule record was approved successfully"
      else
        msg = approval.empty? ? @bm_rule.errors.full_messages : @bm_rule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @bm_rule
  end

  private

  def bm_rule_params
    params.require(:bm_rule).permit(:cod_acct_no, :customer_id, :bene_acct_no, :bene_account_ifsc,
                                    :neft_sender_ifsc, :lock_version, :approval_status, :last_action,
                                    :approved_version, :approved_id, :service_id)
  end

end