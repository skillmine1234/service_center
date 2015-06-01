class AddColumnsToInwIdentities < ActiveRecord::Migration
  def change
    add_column :inw_identities, :whitelisted_identity_id, :integer
    add_column :inw_identities, :was_auto_matched, :string
  end
end
