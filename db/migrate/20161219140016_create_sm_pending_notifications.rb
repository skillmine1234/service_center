class CreateSmPendingNotifications < ActiveRecord::Migration
  def change
    create_table :sm_pending_notifications, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 255, :null => false, :comment => "the UUID of the broker"
      t.string :sm_auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :sm_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.index([:sm_auditable_type, :sm_auditable_id], :unique => true, :name => 'sm_notifications_01')
      t.index([:broker_uuid], :name => 'sm_notifications_02')
    end
  end
end
