class AddColumnFaultSubcodeToPcsAuditSteps < ActiveRecord::Migration
  def change
    add_column :pcs_audit_steps, :fault_subcode, :string, :limit => 50, :comment => "the error code that the third party will return"        
  end
end
