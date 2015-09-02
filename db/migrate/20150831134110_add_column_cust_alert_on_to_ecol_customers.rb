class AddColumnCustAlertOnToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :cust_alert_on, :string, :limit => 1, :default => 'N', :null => false
  end
end
