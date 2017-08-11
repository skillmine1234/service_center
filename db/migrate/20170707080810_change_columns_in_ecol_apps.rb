class ChangeColumnsInEcolApps < ActiveRecord::Migration
  def change
    add_column :ecol_apps, :customer_code, :string, limit: 20, comment: 'the customer_code for this app'
    remove_index :ecol_apps, name: 'ecol_apps_01'
    add_index :ecol_apps, [:app_code, :customer_code, :approval_status], unique: true, name: 'ecol_apps_01'
  end
end
