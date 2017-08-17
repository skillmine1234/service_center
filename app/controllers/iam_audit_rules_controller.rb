class IamAuditRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def new
    @iam_audit_rule = IamAuditRule.new
  end
  
  def edit
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
  end

  def create
    @iam_audit_rule = IamAuditRule.new(params[:ecol_rule])
    if !@iam_audit_rule.valid?
      render "new"
    else
      @iam_audit_rule.created_by = current_user.id
      @iam_audit_rule.save
      flash[:alert] = 'Rule successfully created'
      redirect_to @iam_audit_rule
    end
  end
  
  def update
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
    @iam_audit_rule.attributes = params[:iam_audit_rule]
    if !@iam_audit_rule.valid?
      render "edit"
    else
      @iam_audit_rule.updated_by = current_user.id
      @iam_audit_rule.save
      flash[:alert] = 'Rule successfuly modified'
      redirect_to @iam_audit_rule
    end
    rescue ActiveRecord::StaleObjectError
      @iam_audit_rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 
  
  def index
    iam_audit_rules = IamAuditRule.order("id desc")
    @iam_audit_rules_count = iam_audit_rules.count
    @iam_audit_rules = iam_audit_rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
  end
  
  def audit_logs
    @iam_audit_rule = IamAuditRule.find(params[:id]) rescue nil
    @audit = @iam_audit_rule.audits[params[:version_id].to_i] rescue nil
  end
    
  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'IAM')
  end

  private

  def iam_audit_rule_params
    params.require(:iam_audit_rule).permit(:org_uuid, :cert_dn, :source_ip, :interval_in_mins, :lock_version)
  end
end
