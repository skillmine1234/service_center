class AddMobileNoToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :mobile_no, :string
  end
end
