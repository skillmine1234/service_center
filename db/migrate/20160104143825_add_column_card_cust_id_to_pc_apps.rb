class AddColumnCardCustIdToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :card_cust_id, :string, :limit => 50, :comment => 'the customer that owns the card account no'
    change_column :pc_apps, :card_cust_id, :string, :null => false , default: ""
  end
end
