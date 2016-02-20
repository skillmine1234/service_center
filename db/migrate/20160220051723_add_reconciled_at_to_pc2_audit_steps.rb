class AddReconciledAtToPc2AuditSteps < ActiveRecord::Migration
  def change
    add_column :pc2_audit_steps, :reconciled_at, :datetime, :comment => "the timestamp when the step was reconciled (null if no reconciliation was done/needed)"    
  end
end
