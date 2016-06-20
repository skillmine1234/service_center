class CreateSmBankAccounts < ActiveRecord::Migration
  def change
    create_table :sm_bank_accounts, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :sm_code, :null => false, :limit => 20, :comment => "the unique code assigned to the submember, this associates to sm_banks"
      t.string :customer_id, :null => false, :limit => 15, :comment => "the customer id assigned to the smb, multiple ids can be assigned"
      t.string :account_no, :null => false, :limit => 20, :comment => "the account no of the smb, the customer id specified should own this account"
      t.string :mmid, :null => false, :limit => 7, :comment => "the mmid for the account, required for imps"
      t.string :mobile_no, :null => false, :limit => 10, :comment => "the mobile no as registered with the mmid, required for imps"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
    end
    add_index :sm_bank_accounts, [:sm_code, :customer_id, :account_no, :approval_status], :unique => true, :name => "sm_bank_accounts_01"
  end
end
