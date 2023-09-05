class CreateFtPendingConfirmations < ActiveRecord::Migration[7.0]
  def change
    create_table :ft_pending_confirmations do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 255, :null => false, :comment => "the UUID of the broker"
      t.string :ft_auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :ft_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.index([:ft_auditable_type, :ft_auditable_id], :unique => true, :name => 'ft_confirmations_01')
      t.index([:broker_uuid], :name => 'ft_confirmations_02')
    end
  end
end
