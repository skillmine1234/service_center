class AddRequiredColumnsToFundsTransfers < ActiveRecord::Migration
  def change
  	if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
	    add_column :funds_transfers, :notify_status, :string, :limit => 100, :comment => "the status of the notify step for e.g., NOTIFIED:OK, NOTIFY:REJECTED, NOTIFICATION FAILED and PENDING NOTIFICATION"        
	    add_column :funds_transfers, :notify_attempt_no, :integer, :comment => 'the attempt no of the notify step'  
	    add_column :funds_transfers, :notify_attempt_at, :datetime, :comment => 'the last attempt of the notify step'  
	    add_column :funds_transfers, :notified_at, :datetime, :comment => 'the timestamp when the notification was happened'  
	    add_column :funds_transfers, :notify_result, :string, :limit => 50, :comment => 'the failure reason of the notify step'
	    add_index :funds_transfers, [:notify_status], :name => 'funds_xfer_notify_status'
    end     	
  end
end
