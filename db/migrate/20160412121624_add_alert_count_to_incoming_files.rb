class AddAlertCountToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :alert_count, :integer, :comment => "the number of times an alert has been sent for pending approval"
  end
end
