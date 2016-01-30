class AddSkipFirstToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :skip_first, :string, :limit => 1, :default => 'N', :comment => "the flag which indicates whether to skip the first record (as it is a header)"  
  end
end
