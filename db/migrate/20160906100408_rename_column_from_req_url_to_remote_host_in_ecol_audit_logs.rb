class RenameColumnFromReqUrlToRemoteHostInEcolAuditLogs < ActiveRecord::Migration
  def self.up
    rename_column :ecol_audit_logs, :req_url, :remote_host
  end
  
  def self.down
    rename_column :ecol_audit_logs, :remote_host, :req_url
  end
end
