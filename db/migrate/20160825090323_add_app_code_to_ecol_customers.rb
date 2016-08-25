class AddAppCodeToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :app_code, :string, :limit => 15, :comment => "the unique code of the application"
    EcolCustomer.unscoped.find_each(batch_size: 100) do |c|
      c.app_code = c.code
      c.save(:validate => false)
    end
    change_column :ecol_customers, :app_code, :string, :limit => 15, :null => false, :comment => "the unique code of the application"
  end
end
