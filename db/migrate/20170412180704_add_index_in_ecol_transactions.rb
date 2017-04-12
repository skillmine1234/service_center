class AddIndexInEcolTransactions < ActiveRecord::Migration
  def change
    add_index :ecol_transactions, [:customer_code,:status], name: 'ecol_transactions_02'
  end
end
