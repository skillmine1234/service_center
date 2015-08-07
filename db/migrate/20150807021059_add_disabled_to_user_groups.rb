class AddDisabledToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :disabled, :boolean
  end
end
