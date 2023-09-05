class AddIdForToWhitelistedIdentities < ActiveRecord::Migration[7.0]
  def change
    add_column :whitelisted_identities, :id_for, :string
  end
end
