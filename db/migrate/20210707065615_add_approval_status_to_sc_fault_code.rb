class AddApprovalStatusToScFaultCode < ActiveRecord::Migration
  def change
    add_column :sc_fault_codes, :approval_status, :string, :limit => 1, :default => 'U'
    add_column :sc_fault_codes, :approved_id, :integer, :limit => 1
    add_column :sc_fault_codes, :approved_version, :integer
    add_column :sc_fault_codes, :last_action, :string, :limit => 1, :default => 'C'
    add_column :sc_fault_codes, :created_by, :string,:limit => 20
    add_column :sc_fault_codes, :updated_by, :string, :limit => 20
    add_column :sc_fault_codes, :lock_version, :integer
  end
end