class CreatePendingSmPayments < ActiveRecord::Migration
  def change
    create_table :pending_sm_payments, {:sequence_start_value => '1 cache 20 order increment by 1'} do |table|
      table.string :broker_uuid, :limit => 255, :null => false, :comment => "the UUID of the broker"
      table.integer :sm_payment_id, :null => false, :comment => "the id of the sm_payments record corresponsing to this record"
      table.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
    end
  end
end
