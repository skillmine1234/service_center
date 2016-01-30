class AddColumnValidateAllToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :validate_all, :string, :limit => 1, :default => 'N', :comment => "the flag which indicates whether to process the file if all records are valid"
  end
end