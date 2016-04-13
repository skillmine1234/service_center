class MakeEmailsNullableInSuCustomers < ActiveRecord::Migration
  def change
    change_column :su_customers, :ops_email, :string, :null => true
    change_column :su_customers, :rm_email, :string, :null => true
  end
end
