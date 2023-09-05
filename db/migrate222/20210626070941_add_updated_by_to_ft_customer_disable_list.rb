class AddUpdatedByToFtCustomerDisableList < ActiveRecord::Migration[7.0]
  def change
    add_column :ft_customer_disable_lists, :updated_by, :integer
  end
end
