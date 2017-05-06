class ChangeColumnsInIcCustomers < ActiveRecord::Migration
  def change
    add_column :ic_customers, :sc_backend_code, :string, :limit => 20, :comment => "the name of the system where the customer details are stored"
    change_column :ic_customers, :fee_pct, :number, null: true
    change_column :ic_customers, :fee_income_gl, :string, null: true
    change_column :ic_customers, :max_overdue_pct, :number, null: true
  end
end
