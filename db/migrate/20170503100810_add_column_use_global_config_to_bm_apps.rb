class AddColumnUseGlobalConfigToBmApps < ActiveRecord::Migration
  def change
    add_column :bm_apps, :use_global_config, :string, :limit => 1, default: 'Y', comment: 'the flag to decide global or pre-app values for narrative and userid'
    add_column :bm_apps, :user_id, :string, :limit => 50, comment: 'the user id for the fcr request'
    add_column :bm_apps, :narrative_prefix, :string, :limit => 50, comment: 'the narrative for the fcr request'        
  end
end
