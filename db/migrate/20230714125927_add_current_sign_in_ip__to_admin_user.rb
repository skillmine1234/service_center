class AddCurrentSignInIpToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :current_sign_in_ip, :string
  end
end
