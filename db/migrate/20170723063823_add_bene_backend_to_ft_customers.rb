class AddBeneBackendToFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :bene_backend, :string, limit: 50, null: false, default: 'NETB', comment: 'the beneficiary backend code for this customer'
  end
end
