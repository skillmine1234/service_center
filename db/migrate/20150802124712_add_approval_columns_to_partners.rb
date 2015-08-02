class AddApprovalColumnsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :partners, :last_action, :string, :limit => 1, :default => 'C'
    add_column :partners, :approved_version, :integer
    add_column :partners, :approved_id, :integer
  end
end