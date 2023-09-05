class AddNeftLimitCheckToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :neft_limit_check, :string
  end
end
