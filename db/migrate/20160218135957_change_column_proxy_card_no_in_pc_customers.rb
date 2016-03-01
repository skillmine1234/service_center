class ChangeColumnProxyCardNoInPcCustomers < ActiveRecord::Migration
  def change
    change_column :pc_customers, :proxy_card_no, :string, :null => true
  end
end
