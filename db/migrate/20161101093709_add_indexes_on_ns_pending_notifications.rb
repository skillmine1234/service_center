class AddIndexesOnNsPendingNotifications < ActiveRecord::Migration
  def up
    add_index :ns_pending_notifications, [:auditable_type, :auditable_id], :name => 'ns_notifications_01'
    add_index :ns_pending_notifications, [:broker_uuid, :created_at], :name => 'ns_notifications_02'
  end

  def down
    remove_index :ns_pending_notifications, :name => 'ns_notifications_01'
    remove_index :ns_pending_notifications, :name => 'ns_notifications_02'
  end
end
