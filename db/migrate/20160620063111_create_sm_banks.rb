class CreateSmBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :sm_banks do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :null => false, :limit => 20, :comment => "the unique code assigned to the sub member" 
      t.string :name, :null => false, :limit => 100, :comment => "the name of the sub member"
      t.string :bank_code, :null => false, :limit => 20, :comment => "the bank code of the sub member, all incoming requests are validated against this"
      #t.number :low_balance_alert_at, :null => false, :comment => "the minimum balance that the smb should maintain to avoid alerts"
      t.string :identity_user_id, :null => false, :limit => 20, :comment => "the minimum balance that the smb should maintain to avoid alerts"
      t.string :neft_allowed, :null => false, :limit => 1, :comment => "the flag to indicate if NEFT is allowed"
      t.string :imps_allowed, :null => false, :limit => 1, :comment => "the flag to indicate if IMPS is allowed"
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
    add_index :sm_banks, [:code, :approval_status], :unique => true, :name => "sm_banks_01"
    add_index :sm_banks, [:name,:bank_code], :name => "sm_banks_02"
  end
end
