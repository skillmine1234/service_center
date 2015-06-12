class CreateUsersGroups < ActiveRecord::Migration
  def change
    create_table(:users_groups, :id => false) do |t|
      t.references :user
      t.references :group
    end
  end
end
