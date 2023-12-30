class AddEnabledToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :enabled, :string
  end
end
