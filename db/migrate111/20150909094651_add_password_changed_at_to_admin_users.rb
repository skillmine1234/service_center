class AddPasswordChangedAtToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :password_changed_at, :datetime
    #add_index :admin_users, :password_changed_at
  end
end
