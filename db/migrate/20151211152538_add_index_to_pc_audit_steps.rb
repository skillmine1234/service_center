class AddIndexToPcAuditSteps < ActiveRecord::Migration
  def change
    add_index :pc_audit_steps, [:pc_auditable_type, :pc_auditable_id, :step_no, :attempt_no], :unique => true, :name => "pc_audit_steps_unique_key"
  end
end
