class AddApprovedVersionToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :approved_version, :integer
  end
end
