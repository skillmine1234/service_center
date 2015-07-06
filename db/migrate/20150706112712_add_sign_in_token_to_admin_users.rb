class AddSignInTokenToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :current_sign_in_token, :string
  end
end
