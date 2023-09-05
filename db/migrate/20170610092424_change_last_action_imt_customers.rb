class ChangeLastActionImtCustomers < ActiveRecord::Migration[7.0]
  def change
    change_column :imt_customers, :last_action, :string, :default => 'C'
  end
end
