class ChangeColumnsInPcCustomers < ActiveRecord::Migration
  def change
    change_column :pc_customers, :card_uid, :string, :null => true, :limit => 255, :comment => "the unique id of the card "
    change_column :pc_customers, :card_no, :string, :null => true, :limit => 255, :comment => "the unique no of the card"
  end
end
