class AddNotNullConstraintToEcolPendingSettlements < ActiveRecord::Migration
  def change
    change_column :ecol_pending_settlements, :broker_uuid, :string, null: false
    change_column :ecol_pending_settlements, :ecol_transaction_id, :integer, null: false
    change_column :ecol_pending_settlements, :created_at, :datetime, null: false
  end
end
