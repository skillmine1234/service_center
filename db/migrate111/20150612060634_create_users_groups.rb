class CreateUsersGroups <  ActiveRecord::Migration[7.0]
  def change
    create_table(:users_groups, :id => false) do |t|
      t.references :user
      t.references :group
    end
  end
end
