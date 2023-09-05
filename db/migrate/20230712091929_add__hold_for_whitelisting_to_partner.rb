class AddHoldForWhitelistingToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :hold_for_whitelisting, :string
  end
end
