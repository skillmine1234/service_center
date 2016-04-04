class RemoveAudtiableTypeFromPcsPendingSteps < ActiveRecord::Migration
  def change
    remove_column :pcs_pending_steps, :pcs_auditable_type
    remove_column :pcs_pending_steps, :step_name
  end
end
