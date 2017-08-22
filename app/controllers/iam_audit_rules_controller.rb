class IamAuditRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def edit
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
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

  def show
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
  end
  
  def audit_logs
    @record = IamAuditRule.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  private

  def iam_audit_rule_params
    params.require(:iam_audit_rule).permit(:org_uuid, :cert_dn, :source_ip, :interval_in_mins, :lock_version)
  end
end
