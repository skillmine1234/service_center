class PatchForUserRoles < ActiveRecord::Migration
  def change
    User.find_each(batch_size: 100) do |user|
      UserRole.create(:user_id => user.id, :role_id => user.role_id, :approval_status => 'A') unless user.role_id.nil?
    end
  end
end
