class AddColumnPcsAuditStepIdToPcsPendingSteps < ActiveRecord::Migration
  def change
    add_column :pcs_pending_steps, :pcs_audit_step_id, :integer
    remove_column :pcs_pending_steps, :pcs_auditable_id
  end
end
