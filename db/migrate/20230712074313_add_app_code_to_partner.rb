class AddAppCodeToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :app_code, :string
  end
end
