class AddCreatedByToFtCustomerDisableList < ActiveRecord::Migration[7.0]
  def change
    add_column :ft_customer_disable_lists, :created_by, :integer
  end
end
