class RenameColumnTransferDateInEcolTransactions < ActiveRecord::Migration
  def change
    rename_column :ecol_transactions, :transfer_date, :transfer_timestamp
    change_column :ecol_transactions, :transfer_timestamp, :datetime, :null => false
  end
end
