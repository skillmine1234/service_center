class AddCorpCustomerIdToIcSuppliers < ActiveRecord::Migration
  def change
    add_column :ic_suppliers, :corp_customer_id, :string, :limit => 15, :comment => "the unique ID assigned to the customer"
    db.execute "UPDATE ic_suppliers SET corp_customer_id = 0"
    change_column :ic_suppliers, :corp_customer_id, :string, :limit => 15, :null => false, :comment => "the unique ID assigned to the customer"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end