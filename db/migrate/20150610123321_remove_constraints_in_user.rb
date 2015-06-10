class RemoveConstraintsInUser < ActiveRecord::Migration
  def change
    change_column :users, :encrypted_password, :string, :null => true
    change_column :users, :sign_in_count, :integer,:null => true
  end
end
