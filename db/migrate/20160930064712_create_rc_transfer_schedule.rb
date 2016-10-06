class CreateRcTransferSchedule < ActiveRecord::Migration
  def change
    create_table :rc_transfer_schedule, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 50, :comment => 'the unique code for the beneficiary'  
      t.string :debit_account_no, :limit => 20, :comment => 'the account no of the provider, from where amount needs to be transferred'      
      t.string :bene_account_no, :limit => 20, :comment => 'the account no of the beneficiary, where amount needs to be transferred from provider account'      
      t.datetime :next_run_at, :comment => 'the datetime when the file will next be created' 
      t.datetime :last_run_at, :comment => 'the datetime when the file was last created'   
      t.string :app_code, :limit => 50, :comment => 'the unique code of application, which needs to be called to notify the customer'      
      t.string :is_enabled, :limit => 1, :comment => 'the flag to indicate if beneficiary is enabled'      
      t.integer :last_batch_no, :comment => 'the last batch no'   
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
               
      t.index([:code, :approval_status], :unique => true, :name => 'rc_transfer_schedules_01')              
    end
  end
end
