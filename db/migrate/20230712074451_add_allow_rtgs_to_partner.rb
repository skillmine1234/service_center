class AddAllowRtgsToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :allow_rtgs, :string
  end
end
