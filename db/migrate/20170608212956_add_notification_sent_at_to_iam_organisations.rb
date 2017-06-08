class AddNotificationSentAtToIamOrganisations < ActiveRecord::Migration
  def change
    add_column :iam_organisations, :notification_sent_at, :datetime, comment: 'the timestamp when the notification was sent to the iam_organisation'
  end
end
