class AlterPcCustomers < ActiveRecord::Migration
  def change
    add_column :pc_customers, :activation_code, :string, :limit => 255, :comment => "the code to activate the card"
    add_column :pc_customers, :activated_at, :timestamp,  :comment => "the timestamp of the card activation"  
  end
end
