class AddNotifyDowntimeToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :notify_downtime, :string
  end
end
