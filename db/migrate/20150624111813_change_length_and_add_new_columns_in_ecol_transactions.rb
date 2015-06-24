class ChangeLengthAndAddNewColumnsInEcolTransactions < ActiveRecord::Migration
  def change
    change_column :ecol_transactions, :validation_status, :string, :limit => 50
    change_column :ecol_transactions, :credit_status, :string, :limit => 50
    change_column :ecol_transactions, :settle_status, :string, :limit => 50
    change_column :ecol_transactions, :return_status, :string, :limit => 50
    add_column :ecol_transactions, :credit_result, :string, :limit => 1000
    add_column :ecol_transactions, :settle_result, :string, :limit => 1000
    add_column :ecol_transactions, :return_result, :string, :limit => 1000
  end
end
