class AddValidateVpaToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :validate_vpa, :string
  end
end
