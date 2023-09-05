class AddServiceMidToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :service_mid, :string
  end
end
