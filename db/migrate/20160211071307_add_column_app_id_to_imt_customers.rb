class AddColumnAppIdToImtCustomers < ActiveRecord::Migration
  def change
    add_column :imt_customers, :app_id, :string, :limit => 50, :comment => "the identifier for the client"
    db.execute("UPDATE imt_customers SET app_id = 'app1234'")
    change_column :imt_customers, :app_id, :string, :null => false
  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
end
