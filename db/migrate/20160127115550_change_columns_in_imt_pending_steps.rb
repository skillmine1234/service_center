class ChangeColumnsInImtPendingSteps < ActiveRecord::Migration
  def change
    remove_column :imt_pending_steps, :step_name
    remove_column :imt_pending_steps, :imt_auditable_id
    remove_column :imt_pending_steps, :imt_auditable_type
    add_column :imt_pending_steps, :imt_audit_step_id, :integer, :null => false
  end
end
