class CreateRcTransferSchedule < ActiveRecord::Migration
  def change
    create_table :rc_transfer_schedule, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 50, :comment => 'the unique code for the beneficiary'  
      t.string :debit_account_no, :limit => 20, :comment => 'the account no of the provider, from where amount needs to be transferred'      
      t.string :bene_account_no, :limit => 20, :comment => 'the account no of the beneficiary, where amount needs to be transferred from provider account'      
      t.datetime :next_run_at, :comment => 'the datetime when the file will next be created' 
      t.datetime :last_run_at, :comment => 'the datetime when the file was last created'   
      t.string :app_code, :limit => 50, :comment => 'the unique code of application, which needs to be called to notify to customer'      
      t.string :is_enabled, :limit => 1, :comment => 'the flag to indicate if beneficiary is enabled'      
      t.integer :last_batch_no, :comment => 'the last batch no'      
      t.index([:code], :unique => false, :name => 'rc_transfer_schedules_01')              
    end
  end
end
