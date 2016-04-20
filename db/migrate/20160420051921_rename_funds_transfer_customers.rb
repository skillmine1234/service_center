class RenameFundsTransferCustomers < ActiveRecord::Migration
  def change
    rename_table :funds_transfer_customers, :ft_customers
  end
end
