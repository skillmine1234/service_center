class AddColumnReconciledAtToImtAuditSteps < ActiveRecord::Migration
  def change
    add_column :imt_audit_steps, :reconciled_at, :datetime, :comment => 'the SYSDATE when the transaction was reconciled'
  end
end
