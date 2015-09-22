class EcolRulesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def new
    @ecol_rule = EcolRule.new
  end

  def create
    @ecol_rule = EcolRule.new(params[:ecol_rule])
    if !@ecol_rule.valid?
      render "new"
    else
      @ecol_rule.created_by = current_user.id
      @ecol_rule.save
      flash[:alert] = 'Rule successfully created and is pending for approval'
      redirect_to @ecol_rule
    end
  end

  def edit
    ecol_rule = EcolRule.unscoped.find_by_id(params[:id])
    if ecol_rule.approval_status == 'A' && ecol_rule.unapproved_record.nil?
      params = (ecol_rule.attributes).merge({:approved_id => ecol_rule.id,:approved_version => ecol_rule.lock_version})
      ecol_rule = EcolRule.new(params)
    end
    @ecol_rule = ecol_rule
  end
  
  def update
    @ecol_rule = EcolRule.unscoped.find_by_id(params[:id])
    @ecol_rule.attributes = params[:ecol_rule]
    if !@ecol_rule.valid?
      render "edit"
    else
      @ecol_rule.updated_by = current_user.id
      @ecol_rule.save
      flash[:alert] = 'Rule successfuly modified and is pending for approval'
      redirect_to @ecol_rule
    end
    rescue ActiveRecord::StaleObjectError
      @ecol_rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 
  
  def index
    ecol_rules = EcolRule.unscoped.where("approval_status=?",'U').order("id desc")
    @ecol_rules_count = ecol_rules.count
    @ecol_rules = ecol_rules.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def show
    @ecol_rule = EcolRule.unscoped.find_by_id(params[:id])
  end
  
  def audit_logs
    @ecol_rule = EcolRule.unscoped.find(params[:id]) rescue nil
    @audit = @ecol_rule.audits[params[:version_id].to_i] rescue nil
  end
  
  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end
  
  def approve
    @ecol_rule = EcolRule.unscoped.find(params[:id]) rescue nil
    EcolRule.transaction do
      approval = @ecol_rule.approve
      if @ecol_rule.save and approval.empty?
        flash[:alert] = "Ecollect Rule record was approved successfully"
      else
        msg = approval.empty? ? @ecol_rule.errors.full_messages : @ecol_rule.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @ecol_rule
  end

  private

  def ecol_rule_params
    params.require(:ecol_rule).permit(:ifsc, :cod_acct_no, :stl_gl_inward, :lock_version,
                                      :approval_status, :approved_version, :approved_id, :neft_sender_ifsc,
                                      :customer_id)
  end
end
