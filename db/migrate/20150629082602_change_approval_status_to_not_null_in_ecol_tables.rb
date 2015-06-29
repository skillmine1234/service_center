class ChangeApprovalStatusToNotNullInEcolTables < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    change_column :ecol_remitters, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    change_column :ecol_rules, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    change_column :udf_attributes, :approval_status, :string, :limit => 1, :default => 'U', :null => false
  end
end
