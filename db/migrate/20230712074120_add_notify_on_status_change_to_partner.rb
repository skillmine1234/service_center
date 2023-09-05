class AddNotifyOnStatusChangeToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :notify_on_status_change, :string
  end
end
