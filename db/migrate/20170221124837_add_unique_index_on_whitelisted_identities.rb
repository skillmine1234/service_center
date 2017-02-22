class AddUniqueIndexOnWhitelistedIdentities < ActiveRecord::Migration
  def change
    add_index :whitelisted_identities, :rmtr_code, unique: true, name: 'uk_whitelisted_01'
  end
end
