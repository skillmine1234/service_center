class AddColumnAllowAsyncInFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :allow_async, :string, limit: 1, null: false, default: 'N', comment: 'the flag which indicates whether to allow async or not for the customer'
  end
end
