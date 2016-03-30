class AddMaxDistanceForNameToSuCustomers < ActiveRecord::Migration
  def change
    add_column :su_customers, :max_distance_for_name, :number
  end
end
