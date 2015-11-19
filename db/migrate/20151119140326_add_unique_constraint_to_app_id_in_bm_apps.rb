class AddUniqueConstraintToAppIdInBmApps < ActiveRecord::Migration
  def change
    add_index :bm_apps, :app_id, :unique => true
  end
end
