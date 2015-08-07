class AddCreatedByAndUpdatedByToUserRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :created_by, :string, :limit => 20
    add_column :user_roles, :updated_by, :string, :limit => 20
  end
end
