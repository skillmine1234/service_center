class AddRequiredColumnsInFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :allow_apbs, :string, :limit => 1, :comment => "the transfer type for aadhar payments"
    add_column :ft_customers, :apbs_user_no, :string, :limit => 50, :comment => "the unique no of the user which will be allocated by NPCI"  
    add_column :ft_customers, :apbs_user_name, :string, :limit => 50, :comment => "the name of the user which will be allocated by NPCI"  
  end
end
