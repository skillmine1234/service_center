class AddAdminApprover < ActiveRecord::Migration
  def change
    AdminRole.create(:name => 'approver_admin') if AdminRole.find_by_name("approver_admin").nil?
  end
end
