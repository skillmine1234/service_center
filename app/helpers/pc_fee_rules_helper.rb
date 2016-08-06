module PcFeeRulesHelper
  def find_pc_fee_rules(params)
    pc_fee_rules = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcFeeRule.unscoped : PcFeeRule
    pc_fee_rules = pc_fee_rules.where("app_id=?",params[:app_id]) if params[:app_id].present?
    pc_fee_rules
  end
end