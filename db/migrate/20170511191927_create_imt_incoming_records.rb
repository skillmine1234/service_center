class CreateImtIncomingRecords < ActiveRecord::Migration
  def change
    create_table :imt_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
    	     t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table"
           t.string  :file_name, :limit => 50, :comment => "the name of the incoming_file"
           t.number  :srl_no, :limit => 50, :comment => ""
           t.string  :issuing_bank_name, :limit => 50, :comment => "the name of the bank which issued"
           t.string  :acquiring_bank_name, :limit => 50, :comment => "the name of the bank that processes payments on behalf of merchant"
           t.string  :imt_id, :limit => 15, :comment => ""
           t.datetime  :issuing_transaction_date, :comment => "the timestamp of the transaction issued"
           t.datetime  :acquiring_transaction_date, :comment => "the timestamp when the record was created"
           t.datetime  :chargeback_action_date, :comment => ""
           t.string  :issuing_bank_txn_id, :limit => 50, :comment => "the transaction id of the bank which issued"
           t.string  :acquiring_bank_txn_id, :limit => 50,:comment => "the transaction id of the acquiring bank"
           t.string  :txn_status,  :comment => "the status of the transaction"
           t.string  :drcr_flag, :limit => 2, :comment => "the flag that indicates either debited or credited"
           t.number  :amount, :limit => 50, :comment => "the amount which needs to be transferred"
           t.number  :acquiring_fee, :limit => 20, :comment => "the amount charged for processing"
           t.number  :sc_on_acquiring_fee, :limit => 20, :comment => "service charge on acquiring fee"
           t.number  :npci_charges, :limit => 20,:comment => "the amount charged by NPCI for processing"
           t.number  :sc_on_npci_charges, :limit => 20,:comment => "service charge on npci charges"
           t.number  :total_net_position,:limit => 50, :comment => ""
           t.index([:incoming_file_record_id], :unique => true, :name => 'imt_incoming_records_01')
    end
  end
end
