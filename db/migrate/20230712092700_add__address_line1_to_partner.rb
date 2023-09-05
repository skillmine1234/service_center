class AddAddressLine1ToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :address_line1, :string
  end
end
