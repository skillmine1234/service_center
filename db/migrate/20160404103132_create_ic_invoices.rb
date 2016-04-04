class CreateIcInvoices < ActiveRecord::Migration
  def change
    create_table :ic_invoices, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :corp_customer_id, :limit => 15, :null => false, :comment => "the customer id of the corporate, who approved the discounting"
      t.string :supplier_code, :limit => 15, :null => false, :comment => "the supplier code of the supplier, who''s invoice was discounted"
      t.string :invoice_no, :limit => 28, :null => false, :comment => "the invoice no"
      t.date :invoice_date, :null => false, :comment => "the invoice date"
      t.date :invoice_due_date, :null => false, :comment => "the invoice due date"
      t.number :invoice_amount, :null => false, :comment => "the invoice amount"
      t.number :fee_amount, :null => false, :comment => "the fee amount in the request"
      t.number :discounted_amount, :null => false, :comment => "the discounted amount extended as credit to the supplier"
      t.date :credit_date, :null => false, :comment => "the credit extension date"
      t.string :credit_ref_no, :null => false, :limit => 64, :comment => "the reference no of the credit extension, as seen in the statement"
      t.string :pm_utr, :limit => 64, :comment => "the incoming neft/rtgs UTR"
      t.number :repaid_amount, :null => false, :default => 0, :comment => "the incoming neft/rtgs UTR "
      t.date :repayment_date, :comment => "the repayment date"
      t.string :repayment_ref_no, :limit => 64, :comment => "the reference no of the repayment"
    end

    add_index "ic_invoices", ["supplier_code","invoice_no","corp_customer_id"], name: "i_ic_inv_supp_code", unique: true
  end
end
