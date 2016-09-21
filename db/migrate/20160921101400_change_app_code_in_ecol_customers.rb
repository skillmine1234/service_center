class ChangeAppCodeInEcolCustomers < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :app_code, :string, :limit => 15, :null => false, :comment => "the unique code of the application"
  end
end
