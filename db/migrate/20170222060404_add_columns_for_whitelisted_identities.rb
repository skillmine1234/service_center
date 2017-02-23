class AddColumnsForWhitelistedIdentities < ActiveRecord::Migration
  def change
    add_column :inward_remittances, :rmtr_needs_wl, :string, limit: 1, comment: 'the indicator to specify if the remitter identity is needed'
    add_column :inward_remittances, :rmtr_wl_id, :integer, comment: 'the foreign key to the whitelisted identity of the remitter (if present)'
    add_column :inward_remittances, :bene_needs_wl, :string, limit: 1, comment: 'the indicator to specify if the beneficiary identity is needed'
    add_column :inward_remittances, :bene_wl_id, :integer, comment: 'the foreign key to the whitelisted identity of the beneficiary'


    add_column :whitelisted_identities, :created_for_req_no, :string, null: false, default: 0, comment: 'the req_no of the transaction for which this identity was created'
    add_column :whitelisted_identities, :is_revoked, :string, null: false, default: 'N', limit: 1, comment: 'the indicator to specify if the identity is revoked (and should not be considered)'
    add_column :whitelisted_identities, :id_for, :string, limit: 1, null: false, default: 'N', limit: 1, comment: 'the indicator (R or B) to specify for which party was this identity created)'
  end
end
