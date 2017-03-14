class CreatePc2CustAccounts < ActiveRecord::Migration
  def change
    create_table :pc2_cust_accounts, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :customer_id, :limit => 15, :null => false, :comment => "the id of the customer"
      t.string :account_no, :limit => 20, :null => false, :comment => "the account no of the customer, that is approved for access via the service"
      t.string :is_enabled, :null => false, :limit => 1, :comment => "the flag to decide if the account is enabled or not"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
    end
    add_index :pc2_cust_accounts, [:customer_id, :account_no, :approval_status], :unique => true, :name => "pc2_cust_accounts_01"
  end
end
