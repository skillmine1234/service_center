class AddApprovalColumnsToRcApps < ActiveRecord::Migration
  def up
    add_column :rc_apps, :approval_status, :string, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
    add_column :rc_apps, :approved_version, :integer, :comment => "the version number of the record, at the time it was approved"
    add_column :rc_apps, :approved_id, :integer, :comment => "the id of the record that is being updated"
    
    remove_index :rc_apps, name: 'rc_apps_01'
    
    add_index :rc_apps, [:app_id, :approval_status], unique: true, name: 'rc_apps_02'
  end
  
  def down
    remove_column :rc_apps, :approval_status
    remove_column :rc_apps, :approved_version
    remove_column :rc_apps, :approved_id
    
    add_index :rc_apps, [:app_id], name: 'rc_apps_01'
  end
end
