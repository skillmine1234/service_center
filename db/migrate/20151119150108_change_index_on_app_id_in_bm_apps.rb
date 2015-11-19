class ChangeIndexOnAppIdInBmApps < ActiveRecord::Migration
  def change
    add_index :bm_apps, [:app_id, :approval_status], :unique => true
    remove_index :bm_apps, :app_id
  end
end
