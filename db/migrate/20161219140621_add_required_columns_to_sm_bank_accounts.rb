class AddRequiredColumnsToSmBankAccounts < ActiveRecord::Migration
  def change
  	add_column :sm_bank_accounts, :notify_app_code, :string, :limit => 20, :comment => "the application code which has to be used to send a notification"        
    add_column :sm_bank_accounts, :notify_on_status_change, :string, :limit => 1, :null => false, :default => 'N', :comment => "the indicator which represent whether the notification has to be sent or not"        		
  end
end
