class AddUniqueIndexToBmAuditLogs < ActiveRecord::Migration
  def change
    add_index :bm_audit_logs, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_audit_logs"
    add_index :bm_audit_logs, [:bm_auditable_type, :bm_auditable_id], :unique => true, :name => "auditable_index_audit_logs"
  end
end
