class AddIndexOnColumnsInImtCustomers < ActiveRecord::Migration
  def change
    add_index :imt_customers, :customer_code
    add_index :imt_customers, :customer_name
    add_index :imt_customers, :account_no
  end
end
