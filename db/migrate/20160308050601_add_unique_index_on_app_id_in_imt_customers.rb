class AddUniqueIndexOnAppIdInImtCustomers < ActiveRecord::Migration
  def change
    add_index :imt_customers, [:app_id, :approval_status], :unique => true, :name => "uk1_imt_customers"
  end
end
