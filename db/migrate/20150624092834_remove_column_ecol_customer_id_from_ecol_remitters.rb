class RemoveColumnEcolCustomerIdFromEcolRemitters < ActiveRecord::Migration
  def change
    remove_column :ecol_remitters, :ecol_customer_id
  end
end
