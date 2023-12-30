class AddApprovalColumnsToUserGroups <  ActiveRecord::Migration[7.0]
  def change
    add_column :user_groups, :lock_version, :integer, :default => 0, :null => false
    add_column :user_groups, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :user_groups, :last_action, :string, :limit => 1, :default => 'C'
    add_column :user_groups, :approved_version, :integer
    add_column :user_groups, :approved_id, :integer
    add_column :user_groups, :created_by, :string, :limit => 20
    add_column :user_groups, :updated_by, :string, :limit => 20
  end
end
