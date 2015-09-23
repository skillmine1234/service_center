class RenameReturnIfValFailsInEcolCustomers < ActiveRecord::Migration
  def change
    rename_column :ecol_customers, :return_if_val_fails, :return_if_val_reject
  end
end
