class Cnb2IncomingRecords < ActiveRecord::Migration
  def change
    create_table :cnb2_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table" 
      t.string  :file_name, :limit => 100, :comment => "the name of the incoming_file"      
      t.string  :run_date, :limit => 50, :comment => "the run date of this paymnet"
      t.string  :add_identification, :limit => 50, :comment => "the additional identification for this paymnet"
      t.string  :pay_comp_code, :limit => 50, :comment => "the paying company code"
      t.string  :doc_no, :limit => 50, :comment => "the document number of the payment document "
      t.string  :amount, :limit => 50, :comment => "the payment amount"
      t.string  :currency, :limit => 50, :comment => "the currency key"
      t.string  :pay_method, :limit => 50, :comment => "the payment method for this payment"
      t.string  :vendor_code, :limit => 50, :comment => "the account number of vendor or creditor"
      t.string  :payee_title, :limit => 50, :comment => "the title of the payee"
      t.string  :payee_name, :limit => 255, :comment => "the name of the payee"
      t.string  :payee_addr1, :limit => 50, :comment => "the name of the payee"
      t.string  :payee_addr2, :limit => 50, :comment => "the name of the payee"
      t.string  :payee_addr3, :limit => 50, :comment => "the postal code of the payee  "
      t.string  :payee_addr4, :limit => 50, :comment => "the city of the payee"
      t.string  :payee_addr5, :limit => 50, :comment => "the street and house number of the payee "
      t.string  :house_bank, :limit => 50, :comment => "the short key for a house bank"
      t.string  :acct_dtl_id, :limit => 50, :comment => "the id for account details"
      t.string  :value_date, :limit => 50, :comment => "the posting date"
      t.string  :system_date, :limit => 50, :comment => "the system date"
      t.string  :delivery_mode, :limit => 50, :comment => "the delivery mode "
      t.string  :cheque_no, :limit => 50, :comment => "the cheque no "
      t.string  :pay_location, :limit => 50, :comment => "the dd location"
      t.string  :bene_account_no, :limit => 50, :comment => "the beneficiary account number"
      t.string  :ifsc_code, :limit => 50, :comment => "the ifsc code for this payment"
      t.string  :bank_name, :limit => 50, :comment => "the bank name "
      t.string  :bene_mail_id, :limit => 255, :comment => "the email id of beneficiary"
      t.index([:incoming_file_record_id,:file_name], :unique => true, :name => 'cnb2_incoming_records_01')        
    end
  end
end                                                                                                                                                                                               