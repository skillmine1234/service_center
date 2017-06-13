class RemoveColumnFromFtCustomers < ActiveRecord::Migration
  def change
    remove_column :ft_customers, :allow_start_transfer
  end
end
