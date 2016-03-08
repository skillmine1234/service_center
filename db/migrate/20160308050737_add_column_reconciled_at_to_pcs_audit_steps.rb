class AddColumnReconciledAtToPcsAuditSteps < ActiveRecord::Migration
  def change
    add_column :pcs_audit_steps, :reconciled_at, :datetime
  end
end
