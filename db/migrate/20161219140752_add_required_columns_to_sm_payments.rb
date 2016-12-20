class AddRequiredColumnsToSmPayments < ActiveRecord::Migration
  def change
 	add_column :sm_payments, :notify_status, :string, :limit => 100, :comment => "the status of the notify step for e.g., NOTIFIED:OK, NOTIFY:REJECTED, NOTIFICATION FAILED and PENDING NOTIFICATION"        
	add_column :sm_payments, :notify_attempt_no, :integer, :comment => 'the attempt no of the notify step'  
	add_column :sm_payments, :notify_attempt_at, :datetime, :comment => 'the last attempt of the notify step'  
	add_column :sm_payments, :notified_at, :datetime, :comment => 'the timestamp when the notification was happened'  
	add_column :sm_payments, :notify_result, :string, :limit => 50, :comment => 'the failure reason of the notify step'
	add_index :sm_payments, [:notify_status], :name => 'sm_payments_02' 	
  end
end
