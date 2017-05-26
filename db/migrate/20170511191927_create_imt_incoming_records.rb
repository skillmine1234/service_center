class CreateImtIncomingRecords < ActiveRecord::Migration
  def change
    create_table :imt_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
    	t.integer :incoming_file_record_id, :null => false, :comment => "the foreign key to the incoming_files table"
      t.string :file_name, :limit => 50, :null => false, :comment => "the name of the incoming_file"
      t.integer :record_no, :null => false, :comment => "the serial no of the imt transaction which has come in the file"
      t.string :issuing_bank, :null => false, :limit => 50, :comment => "the name of the bank which issued"
      t.string :acquiring_bank, :null => false, :limit => 50, :comment => "the name of the bank that processes payments on behalf of merchant"
      t.string :imt_ref_no, :null => false, :limit => 35, :comment => "the unique reference no through which imt has been initiated"
      t.datetime :txn_issue_date, :null => false, :comment => "the timestamp of the transaction when it has been issued"
      t.datetime :txn_acquire_date, :null => false, :comment => "the timestamp when the transaction was created"
      t.datetime :chargeback_action_date, :comment => "the timestamp of the return of funds to a consumer, forcibly initiated by the issuing bank of the instrument used by a consumer to settle a debt"
      t.string :issuing_bank_txn_id, :limit => 50, :null => false, :comment => "the transaction id of the bank which issued"
      t.string :acquiring_bank_txn_id, :limit => 50,:comment => "the transaction id of the acquiring bank"
      t.string :txn_status,  :comment => "the status of the imt transaction"
      t.string :crdr, :limit => 2, :null => false, :comment => "the flag that indicates either debited or credited"
      t.number :amount, :null => false, :comment => "the amount which has been transferred"
      t.number :acquiring_fee, :null => false, :comment => "the card-issuing bank deducts the interchange fee from the amount it pays the acquiring bank that handles a credit or debit card transaction for a customer"
      t.number :sc_on_acquiring_fee, :null => false, :comment => "service charge on acquiring fee"
      t.number :npci_charges, :null => false, :comment => "the amount charged by NPCI for processing"
      t.number :sc_on_npci_charges, :null => false, :comment => "the service charge on npci charges"
      t.number :total_net_position, :null => false, :comment => "the value of the position subtracting the initial cost of setting up the position"
      t.index([:incoming_file_record_id,:file_name], :unique => true, :name => 'imt_incoming_records_01')
    end
  end
end
