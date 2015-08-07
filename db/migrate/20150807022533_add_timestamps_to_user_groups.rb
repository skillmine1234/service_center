class AddTimestampsToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :created_at, :datetime
    add_column :user_groups, :updated_at, :datetime
  end
end
