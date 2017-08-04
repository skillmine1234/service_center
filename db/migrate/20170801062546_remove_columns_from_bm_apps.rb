class RemoveColumnsFromBmApps < ActiveRecord::Migration
  def change
    remove_column :bm_apps, :is_configuration_global, :string
    remove_column :bm_apps, :flex_user_id, :string
    remove_column :bm_apps, :flex_narrative_prefix, :string
  end
end
