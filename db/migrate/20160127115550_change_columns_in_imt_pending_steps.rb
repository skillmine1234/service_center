class ChangeColumnsInImtPendingSteps < ActiveRecord::Migration
  def change
    remove_column :imt_pending_steps, :step_name
    remove_column :imt_pending_steps, :imt_auditable_id
    remove_column :imt_pending_steps, :imt_auditable_type
    add_column :imt_pending_steps, :imt_audit_step_id, :integer, :default => 1
    db.execute "UPDATE imt_pending_steps SET imt_audit_step_id = 1"
    change_column :imt_pending_steps, :imt_audit_step_id, :integer, :default => 1, :null => false
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
