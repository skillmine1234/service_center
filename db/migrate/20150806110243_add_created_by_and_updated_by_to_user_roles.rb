class AddCreatedByAndUpdatedByToUserRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :user_roles, :created_by, :string, :limit => 20
    add_column :user_roles, :updated_by, :string, :limit => 20
  end
end
