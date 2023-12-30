class AddColumnsToFtCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :ft_customers, :force_saf, :string, :limit => 1, :null => false, :default => 'N', :comment => "the identifier to specify if all transfers will be SAF"    
  end
end
