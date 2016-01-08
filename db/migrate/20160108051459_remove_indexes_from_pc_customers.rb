class RemoveIndexesFromPcCustomers < ActiveRecord::Migration
  def change
    remove_index :pc_customers, :name => "uk_pc_card_custs_2"
    remove_index :pc_customers, :name => "uk_pc_card_custs_3"
    remove_index :pc_customers, :name => "uk_pc_card_custs_4"
  end
end
