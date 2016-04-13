class MakeEmailsNullableInSuCustomers < ActiveRecord::Migration
  def change
    change_column :su_customers, :ops_email, :string, :null => true, :comment => "the email address of the operations team, emails are sent when customer files are rejected"
    change_column :su_customers, :rm_email, :string, :null => true, :comment => "the email address of the relationship manager, emails are sent when fresh credits are rejected"
  end
end
