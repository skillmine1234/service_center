class AddCustomerIdToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :customer_id, :string
  end
end
