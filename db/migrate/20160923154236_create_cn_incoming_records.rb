class CreateCnIncomingRecords < ActiveRecord::Migration
  def change
    create_table :cn_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table" 
      t.string  :file_name, :limit => 50, :comment => "the name of the incoming_file"      
      t.string  :message_type, :limit => 3, :comment => "the message type for the payment"
      t.string  :debit_account_no, :limit => 20, :comment => "the account number of remitter"
      t.string  :rmtr_name, :limit => 50, :comment => "the name of the remitter"
      t.string  :rmtr_address1, :comment => "the address line 1 of the remitter"
      t.string  :rmtr_address2, :comment => "the address line 2 of the remitter"
      t.string  :rmtr_address3, :comment => "the address line 3 of the remitter"
      t.string  :rmtr_address4, :comment => "the address line 4 of the remitter"
      t.string  :bene_ifsc_code, :limit => 50, :comment => "the IFSC code of the beneficiary"
      t.string  :bene_account_no, :limit => 20, :comment => "the account number of the beneficiary where money is to be credited"
      t.string  :bene_name, :comment => "the name as it appears in the beneficiary bank books"
      t.string  :bene_add_line1, :comment => "the address line 1 of the beneficiary"
      t.string  :bene_add_line2, :comment => "the address line 2 of the beneficiary"
      t.string  :bene_add_line3, :comment => "the address line 3 of the beneficiary"
      t.string  :bene_add_line4, :comment => "the address line 4 of the beneficiary"
      t.string  :transaction_ref_no, :limit => 50, :comment => "the Unique identifier for the transaction"
      t.datetime  :upload_date, :comment => "the date of upload"
      t.number :amount, :comment => "the amount to be credited to beneficiary"
      t.string  :rmtr_to_bene_note, :comment => "the purpose of the payment"
      t.string  :add_info1, :limit => 50, :comment => "the Additional information about the payment"
      t.string  :add_info2, :limit => 50, :comment => "the Additional information about the payment"
      t.string  :add_info3, :limit => 50, :comment => "the Additional information about the payment"
      t.string  :add_info4, :limit => 50, :comment => "the Additional information about the payment"
      t.index([:incoming_file_record_id,:file_name], :unique => true, :name => 'cn_incoming_records_01')      
    end
  end
end
