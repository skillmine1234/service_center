class AddIndexToPc2Apps < ActiveRecord::Migration
  def change
    add_index :pc2_apps, [:app_id, :approval_status, :customer_id], :unique => true, :name => "pc2_apps_01"
  end
end
