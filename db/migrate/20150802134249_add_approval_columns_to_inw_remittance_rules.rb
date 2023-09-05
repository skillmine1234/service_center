class AddApprovalColumnsToInwRemittanceRules < ActiveRecord::Migration[7.0]
  def change
    add_column :inw_remittance_rules, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :inw_remittance_rules, :last_action, :string, :limit => 1, :default => 'C'
    add_column :inw_remittance_rules, :approved_version, :integer
    add_column :inw_remittance_rules, :approved_id, :integer
  end
end