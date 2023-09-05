class AddBeneBackendToFtCustomers < ActiveRecord::Migration[7.0]
  def change
    #add_column :ft_customers, :bene_backend, :string, limit: 50, null: false, default: 'NETB', comment: 'the beneficiary backend code for this customer'
  end
end
