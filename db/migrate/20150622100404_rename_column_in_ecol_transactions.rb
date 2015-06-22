class RenameColumnInEcolTransactions < ActiveRecord::Migration
  def change
    rename_column :ecol_transactions, :vaidation_status, :validation_status
  end
end
