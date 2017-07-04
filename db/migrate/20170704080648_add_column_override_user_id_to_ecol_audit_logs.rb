class AddColumnOverrideUserIdToEcolAuditLogs < ActiveRecord::Migration
  def change
    add_column :ecol_audit_logs, :override_user_id, :integer, comment: 'the id of the user who overrides the transaction status manually'
  end
end
