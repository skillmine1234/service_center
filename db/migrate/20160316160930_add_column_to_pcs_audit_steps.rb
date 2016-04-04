class AddColumnToPcsAuditSteps < ActiveRecord::Migration
  def change
    add_column :pcs_audit_steps, :last_requery_at, :datetime, :comment => "the last time requery was run for this step"
    add_column :pcs_audit_steps, :requery_attempt_no, :integer, :comment => "the times for which requery has been run for this step"
    add_column :pcs_audit_steps, :requery_for, :integer, :comment => "the step for which this is a requery step"
    add_column :pcs_audit_steps, :requery_result, :string, :comment => "the result of the requery e.g., completed, failed, not found, in process"
  end
end
