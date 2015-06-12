class ChangeCustomerIdInPartners < ActiveRecord::Migration
  def change
    change_column :partners, :customer_id, :string, :limit => 15
  end
end
