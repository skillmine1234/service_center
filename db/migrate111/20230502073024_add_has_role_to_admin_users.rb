class AddHasRoleToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :has_role, :string
  end
end
