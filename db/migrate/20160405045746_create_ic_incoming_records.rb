class CreateIcIncomingRecords < ActiveRecord::Migration
  def change
    create_table :ic_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :incoming_file_record_id, :null => false, :comment => "the foreign key for the corresponding record in incoming_file_records"
      t.string :supplier_code, :limit => 15, :comment => "the supplier code of the supplier, who''s credit is being repaid"
      t.string :invoice_no, :limit => 28, :comment => "the invoice no"
      t.date :invoice_date, :comment => "the invoice date"
      t.date :invoice_due_date, :comment => "the invoice due date"
      t.number :invoice_amount, :comment => "the invoice amount, this is also the paid amount as invoices are paid only in full"
      t.string :debit_ref_no, :limit => 64, :comment => "the reference no of the repayment (debit) as will be seen in the statement"
    end

    add_index :ic_incoming_records, :incoming_file_record_id, :name => "ic_record_index", :unique => true
  end
end
