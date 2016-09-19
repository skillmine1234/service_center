class CreatePcIncomingRecords < ActiveRecord::Migration
  def change
    create_table :pc_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
          t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table"
          t.string :file_name, :limit => 50, :comment => "the name of the incoming_file"
          t.string :program_code, :limit => 20, :comment => "the unique code for the program"
          t.string :mobile_no, :limit => 20, :comment => "the mobile no of the customer"
          t.string :is_credit, :limit => 20, :comment => "the indicator to show whether the credit has to be done"
          t.string :is_debit, :limit => 20, :comment => "the indicator to show whether the debit has to be done"
          t.number :transfer_amount, :limit => 20, :comment => "the amount which needs to be transferred"
          t.string :req_reference_no, :limit => 100, :comment => "the unique no, which ESB sends to MM api"
          t.string :status_code, :limit => 10, :comment => "the status of the record"
          t.string :rep_reference_no, :limit => 100,:comment => "the unique no which MM returns in the response"
          t.string :rep_text, :limit => 100, :comment => "the address of the remitter"
          t.string :fault_code, :limit => 255, :comment => "the code that identifies the exception, if an exception occured in the ESB"
          t.string :fault_subcode, :limit => 50, :comment => "the error code that the third party will return"
          t.string :fault_reason, :limit => 1000, :comment => "the english reason of the exception, if an exception occurred in the ESB"

          t.index([:incoming_file_record_id], :unique => true, :name => 'pc_incoming_records_01')      
    end
  end
end
