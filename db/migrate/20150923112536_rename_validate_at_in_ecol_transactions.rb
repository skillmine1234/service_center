class RenameValidateAtInEcolTransactions < ActiveRecord::Migration
  def change
    rename_column :ecol_transactions, :validate_at, :validate_attempt_at
  end
end
