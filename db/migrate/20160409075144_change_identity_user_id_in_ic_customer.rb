class ChangeIdentityUserIdInIcCustomer < ActiveRecord::Migration
  def change
    change_column :ic_customers, :identity_user_id, :string, :null => true, :limit => 20, :comment => "the security identitiy issued to the customer"
  end
end
