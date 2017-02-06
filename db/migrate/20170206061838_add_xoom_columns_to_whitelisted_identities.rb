class AddXoomColumnsToWhitelistedIdentities < ActiveRecord::Migration
  def change
    add_column :whitelisted_identities, :bene_account_no, :string, limit: 30, comment: 'the account number of the beneficiary to which the identity belongs'
    add_column :whitelisted_identities, :bene_account_ifsc, :string, limit: 15, comment: 'the account number of the beneficiary to which the identity belongs'
    add_column :whitelisted_identities, :rmtr_code, :string, limit: 30, comment: 'the partner assigned code of the remitter to which the identity belongs'
  end
end
