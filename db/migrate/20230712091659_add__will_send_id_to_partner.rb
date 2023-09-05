class AddWillSendIdToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :will_send_id, :string
  end
end
