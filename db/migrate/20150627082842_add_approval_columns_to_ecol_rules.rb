class AddApprovalColumnsToEcolRules < ActiveRecord::Migration
  def change
    add_column :ecol_rules, :approval_status, :string, :limit => 1, :default => 'U'
    add_column :ecol_rules, :last_action, :string, :limit => 1, :default => 'C'
    add_column :ecol_rules, :approved_version, :integer
    add_column :ecol_rules, :approved_id, :integer
  end
end
