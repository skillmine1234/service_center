class AddColumnsToEcolNotifications < ActiveRecord::Migration
  def change
    add_column :ecol_notifications, :req_timestamp, :datetime
    add_column :ecol_notifications, :rep_timestamp, :datetime
    add_column :ecol_notifications, :fault_code, :string
    add_column :ecol_notifications, :fault_reason, :string
  end
end
