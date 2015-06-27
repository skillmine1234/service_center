class AddApprovedIdToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :approved_id, :integer
  end
end
