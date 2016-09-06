class AddIdentityUserIdToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :identity_user_id, :string, :limit => 20, :comment => "the user ID of Customer" 
  end
end