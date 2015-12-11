module FpAuthRulesHelper
  def find_fp_auth_rules(params)
    fp_auth_rules = (params[:approval_status].present? and params[:approval_status] == 'U') ? FpAuthRule.unscoped : FpAuthRule
    fp_auth_rules = fp_auth_rules.where("operation_name=?",params[:operation_name]) if params[:operation_name].present?
    fp_auth_rules
  end
end
