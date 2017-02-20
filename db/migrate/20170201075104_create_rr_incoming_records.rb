class CreateRrIncomingRecords < ActiveRecord::Migration
  def change
    create_table :rr_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
          t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table"
          t.string :file_name, :limit => 50, :comment => "the name of the incoming_file"
          t.string :txn_type, :limit => 4, :comment => "the transaction kind for e.g. NEFT, RTGS and IMPS"
          t.string :return_code, :limit => 20, :comment => "the code which indicates why the transaction cannot be processed"
          t.timestamp :settlement_date, :comment => "the timestamp when the settlement happended for the transaction"
          t.string :bank_ref_no, :limit => 32, :comment => "the unique reference number of the transaction which has been returned by flexcube/atom"
          t.string :reason, :limit => 50, :comment => "the reason why the transaction has not been processed"

          t.index([:incoming_file_record_id], :unique => true, :name => 'rr_incoming_records_01')    
    end
  end
end
