class AddRequiredColumnsToFtAuditSteps < ActiveRecord::Migration
  def change
   add_column :ft_audit_steps, :remote_host, :string, :limit => 500, :comment => "the URL of the calling service"        
   add_column :ft_audit_steps, :req_uri, :string, :limit => 500, :comment => "the URI of the calling service"   
   add_column :ft_audit_steps, :req_header, :text, :comment => "the header which will be passed along with the request"        
   add_column :ft_audit_steps, :rep_header, :text, :comment => "the header which comes after calling the service"            
         
  end
end
