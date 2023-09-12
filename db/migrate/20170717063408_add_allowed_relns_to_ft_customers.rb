class AddAllowedRelnsToFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :allowed_relns, :string, comment: 'the allowed relationships for a customer'
  end
end