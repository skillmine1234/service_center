class ChangeLengthOfColumnNameInEcolCustomer < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :name, :string, :limit => 100
  end
end
