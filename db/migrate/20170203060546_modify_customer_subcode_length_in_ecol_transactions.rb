class ModifyCustomerSubcodeLengthInEcolTransactions < ActiveRecord::Migration
  def up
    change_column :ecol_transactions, :customer_subcode, :string, :limit => 28
  end 
  def down
    change_column :ecol_transactions, :customer_subcode, :string, :limit => 15
  end
end
