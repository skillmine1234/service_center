class AddApprovalColumnsToBanks < ActiveRecord::Migration
  def change
    add_column :banks, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :banks, :last_action, :string, :limit => 1, :default => 'C'
    add_column :banks, :approved_version, :integer
    add_column :banks, :approved_id, :integer
    remove_index :banks, :ifsc
    add_index :banks, [:ifsc,:approval_status], :unique => true
  end
end