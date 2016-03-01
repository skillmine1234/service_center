class AddColumnAppIdToPcCustomers < ActiveRecord::Migration
  def change
    add_column :pc_customers, :app_id, :string, :limit => 50, :null => true, :comment => "the identifier for the client"    
  end
end
