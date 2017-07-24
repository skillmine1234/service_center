class AddColumnFaultSubcodeToBmAuditLogs < ActiveRecord::Migration
  def change
    add_column :bm_audit_logs, :fault_subcode, :string, :limit => 50, :comment =>'the error code that the third party will return'
  end
end
