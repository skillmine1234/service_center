class RenameColumnAppIdInSmAuditLogs < ActiveRecord::Migration
  def change
    rename_column :sm_audit_logs, :app_id, :partner_code
    remove_index :sm_audit_logs, :name => 'uk_sm_audit_logs_1'
    add_index "sm_audit_logs", ["partner_code", "req_no", "attempt_no"], name: "uk_sm_audit_logs_1", unique: true
  end
end
