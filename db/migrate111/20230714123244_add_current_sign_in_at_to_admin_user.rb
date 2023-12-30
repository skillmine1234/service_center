class AddCurrentSignInAtToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :current_sign_in_at, :string
  end
end
