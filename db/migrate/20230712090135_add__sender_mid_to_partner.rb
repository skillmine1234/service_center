class AddSenderMidToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :sender_mid, :string
  end
end
