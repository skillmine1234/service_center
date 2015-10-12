class AddDetailsToBmBillPayment < ActiveRecord::Migration
  def change
    add_column :bm_bill_payments, :param1, :string, :limit => 100, :comment => 'the value of the parameter received in the request'
    add_column :bm_bill_payments, :param2, :string, :limit => 100, :comment => 'the value of the parameter received in the request'
    add_column :bm_bill_payments, :param3, :string, :limit => 100, :comment => 'the value of the parameter received in the request'
    add_column :bm_bill_payments, :param4, :string, :limit => 100, :comment => 'the value of the parameter received in the request'
    add_column :bm_bill_payments, :param5, :string, :limit => 100, :comment => 'the value of the parameter received in the request'
    add_column :bm_bill_payments, :cod_pool_acct_no, :string, :limit => 100, :comment => 'the number of the bill'
    add_column :bm_bill_payments, :bill_date, :date, :comment => 'the date on which the bill was raised'
    add_column :bm_bill_payments, :due_date, :date, :comment => 'the due date of the bill'
    add_column :bm_bill_payments, :bill_number, :string, :limit => 50, :comment => 'the number of the bill'
  end
end
