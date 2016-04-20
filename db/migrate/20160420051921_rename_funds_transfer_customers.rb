class RenameFundsTransferCustomers < ActiveRecord::Migration
  def up
    rename_table :funds_transfer_customers, :ft_customers
  end

  def down
    rename_table :ft_customers, :funds_transfer_customers
  end
end
