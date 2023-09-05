class ChangeValueOfRecordInRoles < ActiveRecord::Migration[7.0]
  def change
    supervisor = Role.find_by(:name => 'approver')
    if !supervisor.nil?
      supervisor.update_attributes(:name => 'supervisor')
    end
  end
end
