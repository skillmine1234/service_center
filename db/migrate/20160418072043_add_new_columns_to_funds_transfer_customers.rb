class AddNewColumnsToFundsTransferCustomers < ActiveRecord::Migration
  def change
    add_column :funds_transfer_customers, :is_retail, :string, :limit => 1, :comment => "the flag to identify whether app_id is for retail or corporate customer"
    add_column :funds_transfer_customers, :allow_rtgs, :string, :limit => 1, :comment => "the flag to identify whether rtgs is allowed for the app_id or not"
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'sqlite3'
      add_column :funds_transfer_customers, :app_id, :string, :limit => 20, :comment => "the unique id assigned to a client app"
      db.execute "UPDATE funds_transfer_customers SET app_id = 'a'" 
      add_index :funds_transfer_customers, [:app_id,:approval_status], :unique => true, :name => "FT_cust_index_on_app_id"
      change_column :funds_transfer_customers, :app_id, :string, :limit => 20, :null => false, :comment => "the unique id assigned to a client app"    
    else
      change_column :funds_transfer_customers, :app_id, :string, :limit => 20, :null => false, :comment => "the unique id assigned to a client app"    
      add_index :funds_transfer_customers, [:app_id,:approval_status], :unique => true, :name => "FT_cust_index_on_app_id"
    end
    change_column :funds_transfer_customers, :customer_id, :string, :null => true, :comment => "the ID of the customer"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end