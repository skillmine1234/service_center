class AddColumnUseGlobalConfigToBmApps < ActiveRecord::Migration
  def change
    add_column :bm_apps, :is_configuration_global, :string, :limit => 1, default: 'Y', comment: 'the flag to decide global or pre-app values for narrative and userid'
    add_column :bm_apps, :flex_user_id, :string, :limit => 50, comment: 'the flex user id for the fcr request'
    add_column :bm_apps, :flex_narrative_prefix, :string, :limit => 50, comment: 'the narrative for the fcr request'        
  end
end
