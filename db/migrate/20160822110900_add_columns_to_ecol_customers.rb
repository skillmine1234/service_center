class AddColumnsToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :skip_credit, :string, :limit => 1, :default => 'N', :comment => "the indicator to denote whether the credit step has to be done"   
    add_column :ecol_customers, :debit_acct_val_fail, :string, :limit => 25, :comment => "the account no which has to debited to return the trasactions for the SMB customers"   
  end
end
