class AddReplyWithBeneNameToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :reply_with_bene_name, :string
  end
end
