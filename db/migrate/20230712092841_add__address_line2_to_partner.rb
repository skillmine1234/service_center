class AddAddressLine2ToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :address_line2, :string
  end
end
