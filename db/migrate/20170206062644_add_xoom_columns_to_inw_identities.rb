class AddXoomColumnsToInwIdentities < ActiveRecord::Migration
  def change
    add_column :inw_identities, :auto_matched_at, :datetime, comment: 'the datetime at which the identity was matched with whitelisted identities'
    add_column :inw_identities, :partner_rmtr_code, :string, limit: 30, comment: 'the partner assigned code of the remitter to which the identity belongs'
  end
end
