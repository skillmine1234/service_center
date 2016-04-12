class AddEmailColumnsToSuCustomers < ActiveRecord::Migration
  def change
    add_column :su_customers, :ops_email, :string, :limit => 100, :comment => "the email address of the operations team, emails are sent when customer files are rejected"
    add_column :su_customers, :rm_email, :string, :limit => 100, :comment => "the email address of the relationship manager, emails are sent when fresh credits are rejected"
    db.execute "UPDATE su_customers SET ops_email = 'a'"
    db.execute "UPDATE su_customers SET rm_email = 'a'"
    change_column :su_customers, :ops_email, :string, :null => false, :limit => 100, :comment => "the email address of the operations team, emails are sent when customer files are rejected"
    change_column :su_customers, :rm_email, :string, :null => false, :limit => 100, :comment => "the email address of the relationship manager, emails are sent when fresh credits are rejected"
  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
end