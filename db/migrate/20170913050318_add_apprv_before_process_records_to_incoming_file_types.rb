class AddApprvBeforeProcessRecordsToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :apprv_before_process_records, :string, limit: 1, default: 'N', comment: 'the identifier to specify if the file is needed approval to process the records after upload.'    
  end
end
