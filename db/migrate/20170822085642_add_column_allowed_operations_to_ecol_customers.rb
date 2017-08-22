class AddColumnAllowedOperationsToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :allowed_operations, :string, limit: 100, comment: 'the allowed operations for the ecol_customer'
  end
end
