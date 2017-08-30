class ChangeColumnInIamAuditLogs < ActiveRecord::Migration
  def change
    change_column :iam_audit_logs, :cert_dn, :string, limit: 300  
  end
end
