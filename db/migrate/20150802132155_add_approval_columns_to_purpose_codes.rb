class AddApprovalColumnsToPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :purpose_codes, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :purpose_codes, :last_action, :string, :limit => 1, :default => 'C'
    add_column :purpose_codes, :approved_version, :integer
    add_column :purpose_codes, :approved_id, :integer
  end
end