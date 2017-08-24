class ChangeColumnSourceIpInIamAuditLogs < ActiveRecord::Migration
  def change
    change_column :iam_audit_logs, :source_ip, :string, limit: 100
  end
end
