class CreateIcSuppliers < ActiveRecord::Migration
  def change
    create_table :ic_suppliers, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :supplier_code, :null => false, :limit => 15, :comment => "the unique code that identifies the supplier, usually given by the corporate"
      t.string :supplier_name, :null => false, :limit => 100, :comment => "the name of the supplier"
      t.string :customer_id, :null => false, :limit => 15, :comment => "the unique ID assigned to the supplier in the CBS"
      t.string :od_account_no, :null => false, :limit => 20, :comment => "the overdraft account no of the supplier"
      t.string :ca_account_no, :null => false, :limit => 20, :comment => "the overdraft account no of the supplier"
      t.string :is_enabled, :null => false, :limit => 1, :comment => "the flag to decide if the account is enabled or not"
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

    add_index "ic_suppliers", ["supplier_code","customer_id","approval_status"], name: "i_ic_supp_code", unique: true
  end
end
