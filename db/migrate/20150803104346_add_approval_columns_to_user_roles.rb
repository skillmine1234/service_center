class AddApprovalColumnsToUserRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :lock_version, :integer, :default => 0, :null => false
    add_column :user_roles, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :user_roles, :last_action, :string, :limit => 1, :default => 'C'
    add_column :user_roles, :approved_version, :integer
    add_column :user_roles, :approved_id, :integer
  end
end
