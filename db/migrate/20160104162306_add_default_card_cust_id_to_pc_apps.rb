class AddDefaultCardCustIdToPcApps < ActiveRecord::Migration
  def change
    change_column :pc_apps, :card_cust_id, :string, default: ""
  end
end
