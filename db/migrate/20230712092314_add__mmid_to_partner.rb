class AddMmidToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :mmid, :string
  end
end
