class AddServiceNameToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :service_name, :string
  end
end
