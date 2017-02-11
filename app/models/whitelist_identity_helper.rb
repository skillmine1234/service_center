class WhitelistIdentityHelper
  
  def self.auto_match_and_release(id)
    set_connection
    result = plsql.pk_qg_inw_wl_service.auto_match_and_release(pi_wl_id: id, po_fault_code: nil, po_fault_subcode: nil, po_fault_reason: nil)
  end
  
  def self.try_release(id)
    set_connection
    result = plsql.pk_qg_inw_wl_service.try_release(pi_txn_id: id, po_fault_code: nil, po_fault_subcode: nil, po_fault_reason: nil)
  end
  
  private
  
  def self.set_connection
    plsql.connection = OCI8.new(ENV['DB_USERNAME'],ENV['DB_PASSWORD'],ENV['DATABASE'])
  end
end