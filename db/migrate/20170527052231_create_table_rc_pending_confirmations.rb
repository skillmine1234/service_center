class CreateTableRcPendingConfirmations < ActiveRecord::Migration
  def change
    create_table :rc_pending_confirmations, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :null => true, :limit => 255, :comment => "the UUID of the broker"
      t.string :rc_auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"      
      t.integer :rc_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created" 
      t.index([:rc_auditable_id, :rc_auditable_type], :unique => true, :name => "rc_pending_confirmations_01")
      t.index([:broker_uuid, :created_at], :name => "rc_pending_confirmations_02")
    end
  end
end