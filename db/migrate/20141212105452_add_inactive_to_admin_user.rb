class AddInactiveToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :inactive, :boolean, :default => false
  end
end
