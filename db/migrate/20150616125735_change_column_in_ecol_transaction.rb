class ChangeColumnInEcolTransaction < ActiveRecord::Migration
  def change
    rename_column :ecol_transactions, :transfer_amount, :transfer_amt
  end
end
