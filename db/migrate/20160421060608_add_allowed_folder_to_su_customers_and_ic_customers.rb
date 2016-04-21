class AddAllowedFolderToSuCustomersAndIcCustomers < ActiveRecord::Migration
  def change
    add_column :su_customers, :allowed_folder, :string, :limit => 500, :comment => 'the folder designated for this customer, only files placed in this folder will be processed, others will be rejected'
    add_column :ic_customers, :allowed_folder, :string, :limit => 500, :comment => 'the folder designated for this customer, only files placed in this folder will be processed, others will be rejected'
  end
end