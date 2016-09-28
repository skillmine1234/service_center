class CreateCnIncomingRecords < ActiveRecord::Migration
  def change
    create_table :cn_incoming_records do |t|
      t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table" 
      t.string  :file_name, :limit => 50, :comment => "the name of the incoming_file"      
      t.string  :message_type, :limit => 3, :comment => "R41 indicates RTGS payment type,N06 indicates NEFT payment type,A indicates account to account type"
      t.string  :debit_account_number, :limit => 20, :comment => "YES Bank account number of remitter"
      t.string  :remitter_name, :limit => 50, :comment => "the Remitter name"
      t.string  :address_line1, :limit => 50, :comment => "Address of remitter"
      t.string  :address_line2, :limit => 50, :comment => "Address of remitter"
      t.string  :address_line3, :limit => 50, :comment => "Address of remitter"
      t.string  :address_line4, :limit => 50, :comment => "Address of remitter"
      t.string  :beneficiary_ifsc_code, :limit => 15, :comment => "Beneficiary IFS code. "
      t.string  :beneficiary_account_no, :limit => 35, :comment => "Beneficiary a/c number where money is to be credited"
      t.string  :beneficiary_name, :comment => "Beneficiary name as it appears in the beneficiary bank books"
      t.string  :bene_add_line1, :limit => 50, :comment => "Beneficiary address"
      t.string  :bene_add_line2, :limit => 50, :comment => "Beneficiary address"
      t.string  :bene_add_line3, :limit => 50, :comment => "Beneficiary address"
      t.string  :bene_add_line4, :limit => 50, :comment => "Beneficiary address"
      t.string  :transaction_ref_no, :limit => 100, :comment => "Unique identifier for the transaction. This field will be used for sending email advices and also for reconciliation of payments"
      t.datetime  :upload_date, :comment => "Date format – dd/mm/yyyy.Date of upload"
      t.string  :amount, :limit => 50, :comment => "Amount to be credited to beneficiary"
      t.string  :sender_to_receiver_info, :limit => 50, :comment => "Purpose of the payment"
      t.string  :add_info1, :limit => 50, :comment => "Additional information about the payment"
      t.string  :add_info2, :limit => 50, :comment => "Additional information about the payment"
      t.string  :add_info3, :limit => 50, :comment => "Additional information about the payment"
      t.string  :add_info4, :limit => 50, :comment => "Additional information about the payment"
      t.index([:incoming_file_record_id,:file_name], :unique => true, :name => 'cn_incoming_records_1')      
    end
  end
end