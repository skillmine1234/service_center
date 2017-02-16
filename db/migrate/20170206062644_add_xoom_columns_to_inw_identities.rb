class AddXoomColumnsToInwIdentities < ActiveRecord::Migration
  def change
    add_column :inw_identities, :auto_matched_at, :datetime, comment: 'the datetime at which the identity was matched with whitelisted identities'
  end
end
