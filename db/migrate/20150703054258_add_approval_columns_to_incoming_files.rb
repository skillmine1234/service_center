class AddApprovalColumnsToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :incoming_files, :last_action, :string, :limit => 1, :default => 'C'
    add_column :incoming_files, :approved_version, :integer
    add_column :incoming_files, :approved_id, :integer
  end
end
