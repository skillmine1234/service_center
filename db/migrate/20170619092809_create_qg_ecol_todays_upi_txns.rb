class CreateQgEcolTodaysUpiTxns < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
        QgEcolTodaysUpiTxn.connection
      end
      create_table :qg_ecol_todays_upi_txns, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.string :rrn, :limit => 30, :null => false, :comment => "the RRN of incoming ecollect payment"
        t.string :transfer_type, :limit => 3, :null => false, :comment => "the type of the transfer i.e. UPI"
        t.string :transfer_status, :limit => 25, :comment => "the status of the transfer"
        t.string :transfer_unique_no, :limit => 64, :null => false, :comment => "the unique transfer number"
        t.string :rmtr_ref, :limit => 64, :comment => "the remarks of the remitter"
        t.string :bene_account_ifsc, :limit => 20, :null => false, :comment => "the beneficiary account ifsc code"
        t.string :bene_account_no, :limit => 64, :null => false, :comment => "the virtual account no"
        t.string :bene_account_type, :limit => 10, :comment => "the account type of the beneficiary"
        t.string :rmtr_account_ifsc, :limit => 20, :null => false, :comment => "the remitter account ifsc code"
        t.string :rmtr_account_no, :limit => 64, :null => false, :comment => "the remitter account no"
        t.string :rmtr_account_type, :limit => 10, :comment => "the account type of the sender"
        t.integer :transfer_amt, :null => false, :comment => "the transfer amount"
        t.string :transfer_ccy, :limit => 5, :null => false, :comment => "the currency code of the amount i.e. INR"
        t.datetime :transfer_date, :null => false, :comment => "the date of the transfer"
        t.string :pool_account_no, :limit => 20, :null => false, :comment => "the bank pool account no"
        t.string :rmtr_to_bene_note, :limit => 255, :comment => "the note from the remitter to the beneficiary, to forward to the beneficiaries bank"
        t.string :rmtr_full_name, :limit => 255, :comment => "the full name of the remitter"
        t.string :rmtr_address, :limit => 255, :comment => "the address of the remitter"
        t.string :bene_full_name, :limit => 255, :comment => "the full name of the beneficiary"
        t.string :status, :limit => 4, :null => false, :comment => "the status of the transfer, whether the value would be S or F"
        t.string :error_code, :limit => 3, :comment => "the error code of the UPI"
      end
      add_index :qg_ecol_todays_upi_txns, :transfer_unique_no, :unique => true, :name => 'qg_ecol_todays_upi_txns_01'
    end  
  end

  def down
    unless Rails.env == 'production'
      def self.connection
        QgEcolTodaysUpiTxn.connection
      end
      drop_table :qg_ecol_todays_upi_txns
    end
  end
end
