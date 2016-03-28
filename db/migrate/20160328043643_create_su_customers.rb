class CreateSuCustomers < ActiveRecord::Migration
  def change
    create_table :su_customers do |t|
      t.string :account_no, :limit => 20,  :comment => "the debit account no of the corporate, duplicate entries are not allowed"
      t.string :customer_id, :limit => 50, :comment =>"the customer id of the corporate, duplicate entries are not allowed"
      t.string :pool_acct_no, :limit => 20,  :comment => "the pool account no for the corporate, multiple corporates can share a pool account"
      t.string :pool_cust_id, :limit => 20,  :comment => "the customer id for the pool account"
      t.string :is_enabled, :limit => 1, :comment =>"the flag to decide if the account is enabled or not "         
      t.string :created_by, :limit => 20, :comment =>"the person who creates the record"   
      t.string :updated_by, :limit => 20, :comment =>"the person who updates the record"   
      t.datetime :created_at,  :comment =>"the timestamp when the file was created"   
      t.datetime :updated_at,  :comment =>"the timestamp when the record was last updated"   
      t.integer :lock_version,  :comment =>"the version number of the record every update increments this by 1"   
      t.string :approval_status, :limit => 1, :comment =>"the indicator to denote whether this record is pending approval or is approved"   
      t.string :last_action, :limit => 1, :comment =>"the last action create or update that was performed on the record"   
      t.integer :approved_version,  :comment =>"the version number of the record at the time it was approved"
      t.integer :approved_id,  :comment =>"the id of the record that is being updated"
      t.index([:customer_id, :approval_status], :unique => false, :name => "uk_su_customers_1")
      t.index([:account_no, :approval_status], :unique => false, :name => "uk_su_customers_2")
    end
  end
end
