class AddRequiredColumnsToEcolCustomers < ActiveRecord::Migration
  def change
  	 add_column :ecol_customers, :should_prevalidate, :string, :limit => 1, default: 'N', null: false,  :comment => "the identifier to specify if a local prevalidation is to be done before calling the webservice"
  end
end
