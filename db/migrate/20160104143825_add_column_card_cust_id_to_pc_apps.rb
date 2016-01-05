class AddColumnCardCustIdToPcApps < ActiveRecord::Migration

  def change
    add_column :pc_apps, :card_cust_id, :string
    db.execute "UPDATE pc_apps SET card_cust_id = 'A' "
    change_column :pc_apps, :card_cust_id, :string, null: false
  end

  private

  def db
    ActiveRecord::Base.connection
  end

end
