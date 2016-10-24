class AddNotifyStatusToInwardRemittances < ActiveRecord::Migration
  def change
    add_column :inward_remittances, :notify_status, :string, :limit => 100, :comment => "the status of the notify step for e.g., NOTIFIED:OK, NOTIFY:REJECTED, NOTIFICATION FAILED and PENDING NOTIFICATION"        
  end
end
