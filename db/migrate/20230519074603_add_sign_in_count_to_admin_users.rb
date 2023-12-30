class AddSignInCountToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :sign_in_count, :integer
  end
end
