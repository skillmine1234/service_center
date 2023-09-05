class AddDisabledToUserGroups <  ActiveRecord::Migration[7.0]
  def change
    add_column :user_groups, :disabled, :boolean
  end
end
