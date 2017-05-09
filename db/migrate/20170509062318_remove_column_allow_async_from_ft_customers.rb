class RemoveColumnAllowAsyncFromFtCustomers < ActiveRecord::Migration
  def change
    remove_column :ft_customers, :allow_async, :string
  end
end
