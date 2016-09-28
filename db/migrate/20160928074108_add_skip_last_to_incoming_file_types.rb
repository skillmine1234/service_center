class AddSkipLastToIncomingFileTypes < ActiveRecord::Migration
  def up
    add_column :incoming_file_types, :skip_last, :string, :limit => 1, :default => 'N', :null => false, :comment => "the flag which indicates whether to skip the last record"
  end

  def down
    remove_column :incoming_file_types
  end
end
