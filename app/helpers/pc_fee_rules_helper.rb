module PcFeeRulesHelper
  def find_pc_fee_rules(params)
    pc_fee_rules = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcFeeRule.unscoped : PcFeeRule
    pc_fee_rules = pc_fee_rules.where("program_code=?",params[:program_code]) if params[:program_code].present?
    pc_fee_rules
  end
end
