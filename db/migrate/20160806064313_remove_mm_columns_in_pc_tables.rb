class RemoveMmColumnsInPcTables < ActiveRecord::Migration
  def change
    remove_column :pc_apps, :mm_host
    remove_column :pc_apps, :mm_consumer_key
    remove_column :pc_apps, :mm_consumer_secret
    remove_column :pc_apps, :mm_card_type
    remove_column :pc_apps, :mm_email_domain
    remove_column :pc_apps, :mm_admin_host
    remove_column :pc_apps, :mm_admin_password
    remove_column :pc_apps, :mm_admin_user
    remove_column :pc_fee_rules, :app_id
  end
end
