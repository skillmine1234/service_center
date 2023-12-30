class AddAllowNeftToPartners < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :allow_neft, :string
  end
end
