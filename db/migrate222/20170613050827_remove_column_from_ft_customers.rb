class RemoveColumnFromFtCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :ft_customers, :allow_start_transfer
  end
end
