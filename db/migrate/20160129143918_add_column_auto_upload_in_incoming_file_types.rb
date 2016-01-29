class AddColumnAutoUploadInIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :auto_upload, :string, :limit => 1, :default => 'N', :comment => "the flag which indicates whether to auto-upload the file or not"
  end
end
