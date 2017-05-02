class AddAsyncColumnsToFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :allow_async, :string, limit: 1, null: false, default: 'N', comment: 'the flag which indicates whether to allow async or not for the customer'
    add_column :ft_customers, :allow_start_transfer, :string, limit: 1, null: false, default: 'N', comment: 'the flag which indicates whether to allow startTransfer operation or not for the customer'
  end
end
