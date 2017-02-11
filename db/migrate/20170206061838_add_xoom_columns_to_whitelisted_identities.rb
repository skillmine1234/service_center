class AddXoomColumnsToWhitelistedIdentities < ActiveRecord::Migration
  def change
    add_column :whitelisted_identities, :bene_account_no, :string, limit: 30, comment: 'the account number of the beneficiary to which the identity belongs'
    add_column :whitelisted_identities, :bene_account_ifsc, :string, limit: 15, comment: 'the account number of the beneficiary to which the identity belongs'
    add_column :whitelisted_identities, :rmtr_code, :string, limit: 30, comment: 'the partner assigned code of the remitter to which the identity belongs'
    add_column :whitelisted_identities, :created_for_identity_id, :integer, comment: 'the identity in the transaction for which this whitelisted identity was created'
    add_column :whitelisted_identities, :created_for_txn_id, :integer, comment: 'the tranaction for which this whitelisted identity was created'
  end
end
