class AddReqRefsToEcolAuditLogs < ActiveRecord::Migration
  def change
    add_column :ecol_audit_logs, :req_ref, :string, :limit => 64
  end
end
