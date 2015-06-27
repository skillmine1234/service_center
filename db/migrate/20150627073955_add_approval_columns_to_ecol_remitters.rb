class AddApprovalColumnsToEcolRemitters < ActiveRecord::Migration
  def change
    add_column :ecol_remitters, :approval_status, :string, :limit => 1, :default => 'U'
    add_column :ecol_remitters, :last_action, :string, :limit => 1, :default => 'C'
    add_column :ecol_remitters, :approved_version, :integer
    add_column :ecol_remitters, :approved_id, :integer
    remove_index :ecol_remitters, :name => 'ecol_remitters_unique_index'
    add_index :ecol_remitters, [:customer_code, :customer_subcode, :remitter_code,:invoice_no,:approval_status], :unique => true, :name => 'remitter_index_on_status'
  end
end
