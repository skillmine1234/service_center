class AddApprovalStatusToIcInvoices < ActiveRecord::Migration
  def change
    add_column :ic_invoices, :approval_status, :string, :limit => 1, :comment => "the approval status of invoice"
    db.execute "UPDATE ic_invoices SET approval_status = 'A'"
    change_column :ic_invoices, :approval_status, :string, :limit => 1, :null => false, :comment => 'the approval status of invoice'
    change_column :ic_invoices, :approval_status, :string, :limit => 1, :null => false, :comment => 'the approval status of invoice'
    change_column :ic_invoices, :credit_date, :date,  :null => true, :comment => "the credit extension date"
    change_column :ic_invoices, :credit_ref_no, :string, :limit => 64,:null => true, :comment => "the reference no of the credit extension, as seen in the statement"

  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
end
