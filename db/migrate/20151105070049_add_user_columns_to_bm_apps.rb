class AddUserColumnsToBmApps < ActiveRecord::Migration
  def change
    add_column :bm_apps, :created_by, :string, :limit => 20
    add_column :bm_apps, :updated_by, :string, :limit => 20
  end
end
