class AddNotNullConstraintToEcolPendingValidations < ActiveRecord::Migration
  def change
    change_column :ecol_pending_validations, :broker_uuid, :string, null: false
    change_column :ecol_pending_validations, :ecol_transaction_id, :integer, null: false
    change_column :ecol_pending_validations, :created_at, :datetime, null: false
  end
end
