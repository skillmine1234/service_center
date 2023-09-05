class AddLastSignInAtToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :last_sign_in_at, :string
  end
end
