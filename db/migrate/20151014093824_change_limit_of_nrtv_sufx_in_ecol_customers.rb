class ChangeLimitOfNrtvSufxInEcolCustomers < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :nrtv_sufx_1, :string, :limit => 5
    change_column :ecol_customers, :nrtv_sufx_2, :string, :limit => 5
    change_column :ecol_customers, :nrtv_sufx_3, :string, :limit => 5
  end
end
