class AddAddressLine3ToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :address_line3, :string
  end
end
