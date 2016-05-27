class ChangeIdTypeInWhiltelistedIdentities < ActiveRecord::Migration
  def up
    change_column :whitelisted_identities, :id_type, :string, :limit => 30 
  end
  
  def down
    change_column :whitelisted_identities, :id_type, :string, :limit => 20
  end
end
