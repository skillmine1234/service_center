class CreatePcsPendingSteps < ActiveRecord::Migration
  def change
    create_table :pcs_pending_steps do |t|
      t.string :broker_uuid, :limit => 255, :null => false
      t.string :step_name, :limit => 100, :null => false
      t.integer :pcs_auditable_id, :null => false
      t.string :pcs_auditable_type, :limit => 100, :null => false
      t.datetime :created_at, :null => false
    end
  end
end
