class AddApprovalColumnsToWhitelistedIdentities < ActiveRecord::Migration
  def change
    add_column :whitelisted_identities, :approval_status, :string, :limit => 1, :default => 'U', :null => false
    add_column :whitelisted_identities, :last_action, :string, :limit => 1, :default => 'C'
    add_column :whitelisted_identities, :approved_version, :integer
    add_column :whitelisted_identities, :approved_id, :integer
  end
end