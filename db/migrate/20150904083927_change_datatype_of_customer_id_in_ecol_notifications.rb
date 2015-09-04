class ChangeDatatypeOfCustomerIdInEcolNotifications < ActiveRecord::Migration
  def change
    change_column :ecol_notifications, :ecol_customer_id, :string
  end
end
