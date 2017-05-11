class AddCustomerNameToFundsTransfers < ActiveRecord::Migration
  def change
    add_column :funds_transfers, :customer_name, :string, :limit => 255, :comment => "the name of the customer"    
  end
end
