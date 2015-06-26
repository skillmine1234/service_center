class AddNotNullConstraintToEcolPendingReturns < ActiveRecord::Migration
  def change
    change_column :ecol_pending_returns, :broker_uuid, :string, null: false
    change_column :ecol_pending_returns, :ecol_transaction_id, :integer, null: false
    change_column :ecol_pending_returns, :created_at, :datetime, null: false
  end
end
