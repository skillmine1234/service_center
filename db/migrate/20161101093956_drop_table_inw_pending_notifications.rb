class DropTableInwPendingNotifications < ActiveRecord::Migration
  def change
    drop_table :inw_pending_notifications
  end
end
