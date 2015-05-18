class AddInwRemittancesIdToInwIdentities < ActiveRecord::Migration
  def change
    add_column :inw_identities, :inw_remittance_id, :integer
  end
end
