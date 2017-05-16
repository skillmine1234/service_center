class AddColumnsToFundsTransfers < ActiveRecord::Migration
  if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
    add_column :funds_transfers, :customer_name, :string, :limit => 100, :comment => "the name of the customer"    
    add_column :funds_transfers, :account_mmid, :string, :limit => 10, :comment => "the seven digit number of which the first four digits are the unique identification number of the bank offering IMPS"    
    add_column :funds_transfers, :registered_mobile_no, :string, :limit => 15, :comment => "the mobile no of the registered customer for IMPS"  
  end
end
