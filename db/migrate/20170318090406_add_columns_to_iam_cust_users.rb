class AddColumnsToIamCustUsers < ActiveRecord::Migration
  def change
    add_column :iam_cust_users, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the user'
  end
end
