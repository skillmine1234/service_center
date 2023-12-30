class AddMerchantIdToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :merchant_id, :string
  end
end
