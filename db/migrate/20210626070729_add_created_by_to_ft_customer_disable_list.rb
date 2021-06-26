class AddCreatedByToFtCustomerDisableList < ActiveRecord::Migration
  def change
    add_column :ft_customer_disable_lists, :created_by, :integer
  end
end
