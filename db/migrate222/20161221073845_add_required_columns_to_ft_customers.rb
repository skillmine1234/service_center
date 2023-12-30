class AddRequiredColumnsToFtCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :ft_customers, :is_filetoapi_allowed, :string, :limit => 1, :default => 'N', :comment => "the identifier to tell whether file2api facility is available to the customer"  	
  end
end
