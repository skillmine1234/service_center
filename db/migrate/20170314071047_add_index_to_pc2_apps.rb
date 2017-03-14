class AddIndexToPc2Apps < ActiveRecord::Migration
  def change
     remove_index :pc2_apps, [:app_id, :approval_status]
     add_index :pc2_apps, [:app_id, :customer_id, :approval_status], :unique => true, :name => "pc2_apps_01"
  end
end
