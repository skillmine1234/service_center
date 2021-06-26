class AddUpdatedByToFtCustomerDisableList < ActiveRecord::Migration
  def change
    add_column :ft_customer_disable_lists, :updated_by, :integer
  end
end
