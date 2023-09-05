class RemoveColumnAllowAsyncFromFtCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :ft_customers, :allow_async, :string
  end
end
