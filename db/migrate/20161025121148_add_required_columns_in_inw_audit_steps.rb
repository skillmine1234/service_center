class AddRequiredColumnsInInwAuditSteps < ActiveRecord::Migration
  def change
    add_column :inw_audit_steps, :remote_host, :string, :limit => 500, :comment => "the URL of the calling service"        
    add_column :inw_audit_steps, :req_uri, :string, :limit => 500, :comment => "the URI of the calling service"            
  end
end
