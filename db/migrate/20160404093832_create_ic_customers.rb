class CreateIcCustomers < ActiveRecord::Migration
  def change
    create_table :ic_customers, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :customer_id, :null => false, :limit => 15, :comment => "the unique ID assigned to the customer in the CBS"
      t.string :app_id, :null => false, :limit => 20, :comment => "the app Id issued to the customer"
      t.string :identity_user_id, :null => false, :limit => 20, :comment => "the security identitiy issued to the customer"
      t.string :repay_account_no, :null => false, :limit => 20, :comment => "the account where the customer repays the OD extended to its supplier"
      t.number :fee_pct, :null => false, :precision => 5, :scale => 2, :comment => "the precentage of the invoice amount that is charged as fee for extending credit"
      t.string :fee_income_gl, :null => false, :limit => 20, :comment => "the fee income gl account no"
      t.number :max_overdue_pct, :null => false, :precision => 5, :scale => 2, :comment => "the percentage of total dues that are allowed to be overdue before fresh credits are stopped"
      t.string :cust_contact_email, :null => false, :limit => 100, :comment => "the email address of the customer''s contact"
      t.string :cust_contact_mobile, :null => false, :limit => 10, :comment => "the mobile no of the customer''s contact"
      t.string :ops_email, :null => false, :limit => 100, :comment => "the email address of the operations team, emails are sent when customer files are rejected"
      t.string :rm_email, :null => false, :limit => 100, :comment => "the email address of the relationship manager, emails are sent when fresh credits are rejected"
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

    add_index "ic_customers", ["app_id", "approval_status"], name: "i_ic_cust_app_id", unique: true
    add_index "ic_customers", ["customer_id", "approval_status"], name: "i_ic_cust_cust_id", unique: true
    add_index "ic_customers", ["identity_user_id", "approval_status"], name: "i_ic_cust_identity_id", unique: true
    add_index "ic_customers", ["repay_account_no", "approval_status"], name: "i_ic_cust_repay_no", unique: true
  end
end
