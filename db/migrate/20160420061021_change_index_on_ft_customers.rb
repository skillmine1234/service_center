class ChangeIndexOnFtCustomers < ActiveRecord::Migration
  def change
    remove_index :ft_customers, :column => [:customer_id,:approval_status],:name => "FT_cust_index_on_app_id"
    remove_index :ft_customers, :column => [:app_id,:approval_status], :name => "FT_cust_index_on_customer_id"
    add_index :ft_customers, [:app_id,:customer_id,:approval_status], :unique => true, :name => "FT_cust_index_on_app_id"
  end
end
