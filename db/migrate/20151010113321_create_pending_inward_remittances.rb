class CreatePendingInwardRemittances < ActiveRecord::Migration
  def change
    create_table :pending_inward_remittances do |t|
      t.integer :inward_remittance_id, :limit => 30, :null => false
      t.string :broker_uuid, :limit => 255, :null => false

      t.timestamps null: false
    end
  end
end
