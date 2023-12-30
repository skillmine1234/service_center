class AddTransferColumnsToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    # add_column :inward_remittances, :is_self_transfer, :string, :limit => 1
    # add_column :inward_remittances, :is_same_party_transfer, :string, :limit => 1
  end
end
