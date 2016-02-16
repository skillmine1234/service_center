class CreatePc2PendingSteps < ActiveRecord::Migration
  def change
    create_table :pc2_pending_steps, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 255, :null => false, :comment => "the broker uuid number"
      t.datetime :created_at, :null => false, :comment => "the date time that represents the request that is related to this record"
      t.integer :pc2_audit_step_id, :default => 1, :null => false, :comment => "shows the step number of the record"
    end
  end
end