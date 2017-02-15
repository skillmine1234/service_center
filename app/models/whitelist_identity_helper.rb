class WhitelistIdentityHelper
  require "ruby-plsql"
  
  def self.auto_match_and_release(id)
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      result = plsql.pk_qg_inw_wl_service.auto_match_and_release(pi_wl_id: id, po_fault_code: nil, po_fault_subcode: nil, po_fault_reason: nil)
      raise ::Fault::ProcedureFault.new(OpenStruct.new(code: result[:po_fault_code], subCode: result[:po_fault_subcode], reasonText: "#{result[:po_fault_reason]}")) if result[:po_fault_code].present?
    end
  end
  
  def self.try_release(id)
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      result = plsql.pk_qg_inw_wl_service.try_release(pi_txn_id: id, po_fault_code: nil, po_fault_subcode: nil, po_fault_reason: nil)
      raise ::Fault::ProcedureFault.new(OpenStruct.new(code: result[:po_fault_code], subCode: result[:po_fault_subcode], reasonText: "#{result[:po_fault_reason]}")) if result[:po_fault_code].present?
    end
  end
end