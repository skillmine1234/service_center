class AddColumnNeedsPurposeCodeToFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :needs_purpose_code, :string, :limit => 1, :comment => "the flag which indicates whether the purpose_code is mandatory for this customer"
  end
end
