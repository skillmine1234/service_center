class AddNotificationSentAtToServiceTables < ActiveRecord::Migration
  def change
    add_column :ft_customers, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
    add_column :ic_customers, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
    add_column :imt_customers, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
    add_column :partners, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
    add_column :pc2_apps, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
    add_column :sm_banks, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
  end
end
