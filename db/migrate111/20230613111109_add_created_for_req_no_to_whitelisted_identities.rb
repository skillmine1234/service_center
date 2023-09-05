class AddCreatedForReqNoToWhitelistedIdentities < ActiveRecord::Migration[7.0]
  def change
    add_column :whitelisted_identities, :created_for_req_no, :string
  end
end
