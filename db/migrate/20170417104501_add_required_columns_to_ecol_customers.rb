class AddRequiredColumnsToEcolCustomers < ActiveRecord::Migration
  def change
  	 add_column :ecol_customers, :should_prevalidate, :string, :limit => 1, default: 'N', null: false,  :comment => "the identifier to check whether prevalidation is required or not"
  end
end
