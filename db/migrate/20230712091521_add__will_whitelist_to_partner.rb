class AddWillWhitelistToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :will_whitelist, :string
  end
end
