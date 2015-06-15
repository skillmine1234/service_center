class AddColumnBeneFullAddressInEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :bene_full_address, :string, :limit => 255
  end
end
