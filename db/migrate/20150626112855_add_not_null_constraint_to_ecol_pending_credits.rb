class AddNotNullConstraintToEcolPendingCredits < ActiveRecord::Migration
  def change
    change_column :ecol_pending_credits, :broker_uuid, :string, null: false
    change_column :ecol_pending_credits, :ecol_transaction_id, :integer, null: false
    change_column :ecol_pending_credits, :created_at, :datetime, null: false
  end
end
