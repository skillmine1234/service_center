class AddColumnToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :allowed_operations, :string, comment: 'the field to tell which operations are allowed to customer. For e.g. getstatus, acceptPayment, acceptPaymentWithCreditAcctNo, returnPayment'    
  end
end
