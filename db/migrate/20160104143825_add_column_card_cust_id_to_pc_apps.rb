class AddColumnCardCustIdToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :card_cust_id, :string, :limit => 50, :comment => 'the customer that owns the card account no'

    PcApp.all.each do |pc_app|
      pc_app.card_cust_id = "NA"
      pc_app.save!
    end

    change_column :pc_apps, :card_cust_id, :string, :null => false , default: "NA"
  end
end
