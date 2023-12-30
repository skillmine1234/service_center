class AddAnchoridToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :anchorid, :string
  end
end
