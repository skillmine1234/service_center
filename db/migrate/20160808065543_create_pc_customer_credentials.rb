class CreatePcCustomerCredentials < ActiveRecord::Migration
  def change
    create_table :pc_customer_credentials,{:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :username, :null => false, :comment => "the username of the customer"
      t.string :password, :null => false, :comment => "the password of the customer" 
    end
  end
end
