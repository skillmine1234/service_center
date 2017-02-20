class AddCompleteWithFailedRecordsToIncomingFileTypes < ActiveRecord::Migration
  def change
 	add_column :incoming_file_types, :complete_with_failed_records, :string, limit: 1, null: false, default: 'Y', comment: 'the indicator to denote whether the response file has to be generate with failed records or not' 
  end
end
