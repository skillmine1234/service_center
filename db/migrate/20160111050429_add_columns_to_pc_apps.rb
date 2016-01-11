class AddColumnsToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :traceid_prefix, :integer, :comment => 'the prefix to generate a unique request number to be sent to billdesk'
    add_column :pc_apps, :source_id, :string, :limit => 50, :comment => 'the unique code for the bank name'
    db.execute "UPDATE pc_apps SET traceid_prefix = 1 "
    db.execute "UPDATE pc_apps SET source_id = 'qg' "
    change_column :pc_apps, :traceid_prefix, :integer, :null => false, :comment => 'the prefix to generate a unique request number to be sent to billdesk'
    change_column :pc_apps, :source_id, :string, :null => false, :limit => 50, :comment => 'the unique code for the bank name'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
