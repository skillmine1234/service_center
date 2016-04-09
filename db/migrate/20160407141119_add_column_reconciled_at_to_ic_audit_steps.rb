class AddColumnReconciledAtToIcAuditSteps < ActiveRecord::Migration
  def change
    add_column :ic_audit_steps, :reconciled_at, :datetime, :comment => "the time when transaction was reconciled"  
  end
end
