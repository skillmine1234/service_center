class CreateFtPendingConfirmations < ActiveRecord::Migration
  def change
    create_table :ft_pending_confirmations, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 255, :null => false, :comment => "the UUID of the broker"
      t.string :ft_auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :ft_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"  
    end
  end
end
