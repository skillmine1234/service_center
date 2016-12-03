class AddUniqueIndexOnInwAuditLogs < ActiveRecord::Migration
  def change
    add_index :inw_audit_logs, :inward_remittance_id, :unique => true, :name => 'inw_audit_logs_01'
  end
end
