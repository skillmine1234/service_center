class AddAllowUpiToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :allow_upi, :string
  end
end
