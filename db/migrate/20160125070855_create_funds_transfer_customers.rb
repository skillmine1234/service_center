class CreateFundsTransferCustomers < ActiveRecord::Migration
  def change
    create_table :funds_transfer_customers, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :name, :limit => 20, :comment => "Customer Name"
      t.string :tech_email_id, :limit => 255, :comment => "Tech Team E-mail ID of Customer"
      t.string :ops_email_id, :limit => 255, :comment => "OPs Team E-mail ID of Customer"
      t.string :account_no, :limit => 20, :null => false, :comment => "Account No of Customer"
      t.string :account_ifsc, :limit => 20, :null => false, :comment => "Customer Account IFSC Code"
      t.integer :low_balance_alert_at, :null => false, :comment => "Low Balance Alert Amount"
      t.string :identity_user_id, :null => false, :comment => "User ID of Customer"
      t.string :allow_neft, :limit => 1, :null => false, :comment => "Flag to indicate if NEFT is allowed for this customer"
      t.string :allow_imps, :limit => 1, :null => false, :comment => "Flag to indicate if IMPS is allowed for this customer"
      t.string :enabled, :limit => 1, :null => false, :default => 'N', :comment => "Flag to indicate if customer is enabled"
      t.string :customer_id, :null => false, :comment => "Customer ID"
      t.string :mmid, :limit => 7, :comment => "MMID of Customer, required if IMPS is enabled"
      t.string :mobile_no, :limit => 10, :comment => "Mobile No of Customer, Required if IMPS is enabled"
      t.string :country, :comment => "Country"
      t.string :address_line1, :comment => "Adddress Line 1"
      t.string :address_line2, :comment => "Adddress Line 2"
      t.string :address_line3, :comment => "Adddress Line 3"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
    end
  end
end
