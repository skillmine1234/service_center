class ChangeLengthOfFileNameInIc001IncomingFiles < ActiveRecord::Migration
  def change
    change_column :ic001_incoming_files, :file_name, :string, limit: 100
  end
end
