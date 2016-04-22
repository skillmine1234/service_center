class AddIndexToFmAuditSteps < ActiveRecord::Migration
  def change
    add_index "fm_audit_steps", ["auditable_type", "auditable_id", "step_no", "attempt_no"], name: "uk_fm_audit_steps", unique: true
  end
end
