class AddColumnsToEcolAuditLogs < ActiveRecord::Migration
  def change
    add_column :ecol_audit_logs, :req_header, :text, :comment => "the passed headers of the request"
    add_column :ecol_audit_logs, :rep_header, :text, :comment => "the recieved headers in the response"   
    add_column :ecol_audit_logs, :req_uri, :string, :limit => 500, :comment => "the request uri" 
    add_column :ecol_audit_logs, :req_url, :string, :limit => 500, :comment => "the request url"   
  end
end
