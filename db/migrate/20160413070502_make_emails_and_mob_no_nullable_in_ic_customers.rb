class MakeEmailsAndMobNoNullableInIcCustomers < ActiveRecord::Migration
  def change
    change_column :ic_customers, :cust_contact_mobile, :string, :null => true
    change_column :ic_customers, :cust_contact_email, :string, :null => true
    change_column :ic_customers, :ops_email, :string, :null => true
    change_column :ic_customers, :rm_email, :string, :null => true
  end
end
