class PatchForUserGroups < ActiveRecord::Migration
  def change
    UsersGroup.all.each do |user_group|
      UserGroup.create(:user_id => user_group.user_id, :group_id => user_group.group_id, :approval_status => 'A', :disabled => false)
    end
  end
end
