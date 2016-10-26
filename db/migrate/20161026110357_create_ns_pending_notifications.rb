class CreateNsPendingNotifications < ActiveRecord::Migration
  def change
    create_table :ns_pending_notifications , {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 255, :null => false, :comment => "the UUID of the broker"
      t.string :auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this record"
      t.string :app_code, :limit => 20, :null => false, :comment => "the code of the application using that notification will be sent to the customer"
      t.string :service_code, :limit => 20, :null => false, :comment => "the code of the customer service for e.g. inrw/inrw2"
      t.string :pending_approval, :limit => 1, :null => false, :comment => "the indicator that denotes whether a human approval is awaited (Y) or not (N)"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"  
    end
  end
end
