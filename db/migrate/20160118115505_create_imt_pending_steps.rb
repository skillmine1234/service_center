class CreateImtPendingSteps < ActiveRecord::Migration
  def change
    create_table :imt_pending_steps do |t|
      t.string :broker_uuid, :limit => 255, :null => false
      t.string :step_name, :limit => 100, :null => false
      t.integer :imt_auditable_id, :null => false
      t.string :imt_auditable_type, :limit => 100, :null => false
      t.datetime :created_at, :null => false
    end
  end
end
