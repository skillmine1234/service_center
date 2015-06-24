class AddAutoColumnsToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :do_credit, :string, :limit => 1, :default => 'N'
    add_column :ecol_transactions, :do_return, :string, :limit => 1, :default => 'N'
  end
end
