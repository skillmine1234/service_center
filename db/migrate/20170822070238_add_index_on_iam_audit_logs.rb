class AddIndexOnIamAuditLogs < ActiveRecord::Migration
  def change
    add_index :iam_audit_logs, :org_uuid, name: 'iam_audit_logs_01'
  end
end
