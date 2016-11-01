class ModifyStatusCodeInInwAuditSteps < ActiveRecord::Migration
  def up
    change_column :inw_audit_steps, :status_code, :string, :limit => 30, :comment => 'the status of the request'
  end

  def down
    change_column :inw_audit_steps, :status_code, :string, :limit => 25, :comment => 'the status of the request'
  end
end
