class AddUsernameToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :admin_user, :string
  end
end
