class RemoveUnusedColumnsForWhitelistedIdentities < ActiveRecord::Migration
  def change
    remove_column :whitelisted_identities, :created_for_identity_id, :integer, comment: 'the identity in the transaction for which this whitelisted identity was created'
  end
end
