class RemoveTableSuAuditSteps < ActiveRecord::Migration
  def change
    drop_table :su_audit_steps
  end
end
