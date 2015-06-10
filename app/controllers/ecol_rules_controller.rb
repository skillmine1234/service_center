class EcolRulesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def edit
    @ecol_rule = EcolRule.find_by_id(params[:id])
  end
  
  def update
    @ecol_rule = EcolRule.find_by_id(params[:id])
    @ecol_rule.attributes = params[:ecol_rule]
    if !@ecol_rule.valid?
      render "edit"
    else
      @ecol_rule.updated_by = current_user.id
      @ecol_rule.save
      flash[:alert] = 'Rule successfuly modified'
      redirect_to @ecol_rule
    end
    rescue ActiveRecord::StaleObjectError
      @ecol_rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 
  
  def show
    @ecol_rule = EcolRule.find_by_id(params[:id])
  end
  
  def audit_logs
    @ecol_rule = EcolRule.find(params[:id]) rescue nil
    @audit = @ecol_rule.audits[params[:version_id].to_i] rescue nil
  end
  
  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end
  
  private

  def ecol_rule_params
    params.require(:ecol_rule).permit(:ifsc, :cod_acct_no, :stl_gl_inward, :stl_gl_return, :lock_version)
  end
end
