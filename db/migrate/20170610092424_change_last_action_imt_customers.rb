class ChangeLastActionImtCustomers < ActiveRecord::Migration
  def change
    change_column :imt_customers, :last_action, :string, :default => 'C'
  end
end
