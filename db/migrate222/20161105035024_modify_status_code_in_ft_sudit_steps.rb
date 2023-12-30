class ModifyStatusCodeInFtSuditSteps < ActiveRecord::Migration[7.0]
  def up
    if ActiveRecord::Base.connection.table_exists? 'ft_audit_steps'
      change_column :ft_audit_steps, :status_code, :string, :limit => 30, :comment => 'the status of the request'
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists? 'ft_audit_steps'
      change_column :ft_audit_steps, :status_code, :string, :limit => 25, :comment => 'the status of the request'
    end
  end
end
