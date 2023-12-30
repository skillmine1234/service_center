class AddRequiredColumnsToInwardRemittances < ActiveRecord::Migration[7.0]
  def change    
    # add_column :inward_remittances, :notify_attempt_no, :integer, :comment => 'the attempt no of the notify step'  
    # add_column :inward_remittances, :notify_attempt_at, :datetime, :comment => 'the last attempt of the notify step'  
    # add_column :inward_remittances, :notified_at, :datetime, :comment => 'the timestamp when the notification was happened'  
    # add_column :inward_remittances, :notify_result, :string, :limit => 50, :comment => 'the failure reason of the notify step'     
  end
end
