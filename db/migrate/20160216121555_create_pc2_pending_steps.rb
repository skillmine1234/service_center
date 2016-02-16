class CreatePc2PendingSteps < ActiveRecord::Migration
  def change
    create_table :pc2_pending_steps, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 255, :null => false
      t.string :step_name, :limit => 100, :null => false
      t.integer :pc2_auditable_id, :null => false
      t.string :pc2_auditable_type, :limit => 100, :null => false
      t.datetime :created_at, :null => false
    end
  end
end