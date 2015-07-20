class ChangeValueOfRecordInRoles < ActiveRecord::Migration
  def change
    supervisor = Role.find_by(:name => 'approver')
    if !supervisor.nil?
      supervisor.update_attributes(:name => 'supervisor')
    end
  end
end
