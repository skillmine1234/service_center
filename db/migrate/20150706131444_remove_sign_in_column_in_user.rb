class RemoveSignInColumnInUser < ActiveRecord::Migration
  def change
    remove_column :users, :current_sign_in_token
    remove_column :admin_users, :current_sign_in_token
  end
end
