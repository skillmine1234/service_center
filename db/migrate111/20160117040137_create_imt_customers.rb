class CreateImtCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :imt_customers do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :customer_code, :limit => 255, :null => false, :comment => "the unique no of the customer"
      t.string :customer_name, :limit => 255, :null => false, :comment => "the name of the customer"
      t.string :contact_person, :limit => 255, :null => false, :comment => "the name of the contact person"
      t.string :email_id, :limit => 255, :null => false, :comment => "the email id of the customer"
      t.string :is_enabled, :limit => 1, :null => false, :comment =>  "the indicator to denote if the customer is allowed access"
      t.string :mobile_no, :limit => 255, :null => false, :comment => "the mobile no of the customer"
      t.string :account_no, :limit => 255, :null => false, :comment => "the account no of the customer"
      t.integer :expiry_period, :null => false, :comment => "the number of the day in which IMT will expire"
      t.string :txn_mode, :limit => 4, :null => false, :comment => "the indicator to identify whether the transaction will be processed through Api or File Upload"
      t.string :address_line1, :limit => 255, :comment => "the address line1 of the customer"
      t.string :address_line2, :limit => 255, :comment => "the address line2 of the customer"
      t.string :address_line3, :comment => "the address line3 of the customer"
      t.string :country, :comment => "the country of the customer"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps :null => false
    end
  end
end
