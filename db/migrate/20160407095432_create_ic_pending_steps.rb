class CreateIcPendingSteps < ActiveRecord::Migration
  def change     
      create_table :ic_pending_steps, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.string :broker_uuid, :limit => 255, :null => false
        t.integer :ic_audit_step_id, :null => false
        t.datetime :created_at, :null => false      
    end
  end
end
