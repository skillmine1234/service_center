class AddResponseFileColumnsToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :build_response_file, :string, :limit => 1, :comment => "the flag that indicates if a response file is to be created"
    add_column :incoming_file_types, :correlation_field, :string, :comment => "the correlation field, this field will correlate the record between the in file and the response file"
  end
end
