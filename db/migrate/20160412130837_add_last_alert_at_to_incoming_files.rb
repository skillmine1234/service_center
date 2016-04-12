class AddLastAlertAtToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :last_alert_at, :datetime, :comment => "the dateTime when the last alert was sent"
  end
end
