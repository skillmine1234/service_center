class AddColumnIdentityUserIdToImtCustomers < ActiveRecord::Migration
  def change
    add_column :imt_customers, :identity_user_id, :string, :limit => 20, :comment => 'the identity of the user'
    db.execute "UPDATE imt_customers SET identity_user_id = 'a'"
    change_column :imt_customers, :identity_user_id, :string, :limit => 20, :null => false, :comment => 'the identity of the user'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
