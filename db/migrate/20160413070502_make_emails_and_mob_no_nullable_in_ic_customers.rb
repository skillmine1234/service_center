class MakeEmailsAndMobNoNullableInIcCustomers < ActiveRecord::Migration
  def change
    change_column :ic_customers, :cust_contact_mobile, :string, :null => true, :comment => "the mobile no of the customer''s contact"
    change_column :ic_customers, :cust_contact_email, :string, :null => true, :comment => "the email address of the customer''s contact"
    change_column :ic_customers, :ops_email, :string, :null => true, :comment => "the email address of the operations team, emails are sent when customer files are rejected"
    change_column :ic_customers, :rm_email, :string, :null => true, :comment => "the email address of the relationship manager, emails are sent when fresh credits are rejected"
  end
end
