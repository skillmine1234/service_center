class CreateEcolPendingCredits < ActiveRecord::Migration
  def change
    create_table :ecol_pending_credits, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :limit => 500
      t.references :ecol_transaction
      t.datetime :created_at
    end
  end
end
