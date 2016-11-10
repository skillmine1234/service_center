class FileNameLengthChanges < ActiveRecord::Migration
  def up
    change_column :incoming_files, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :incoming_files, :nack_file_name, :string, :limit => 150, :comment => 'the name of the nack file'
    change_column :cn_incoming_files, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :cn_incoming_files, :rej_file_name, :string, :limit => 150, :comment => 'the name of the rej file'
    change_column :cn_incoming_files, :cnb_file_name, :string, :limit => 150, :comment => 'the name of the cnb file'
    change_column :ft_incoming_files, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :su_incoming_files, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :ic_incoming_files, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :pc_mm_cd_incoming_files, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :outgoing_files, :file_name, :string, :limit => 100, :null => false, :comment => 'the name of the file'
    change_column :outgoing_files, :file_path, :string, :limit => 255, :null => false, :comment => 'the path of the file'
    change_column :cn_incoming_records, :file_name, :string, :limit => 100, :comment => 'the name of the cnb file'
    change_column :ft_incoming_records, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :su_incoming_records, :file_name, :string, :limit => 100, :comment => 'the name of the file'
    change_column :ic_incoming_records, :file_name, :string, :limit => 100, :null => false,  :comment => 'the name of the file'
    change_column :pc_mm_cd_incoming_records, :file_name, :string, :limit => 100, :comment => 'the name of the file'
  end

  def down
    change_column :incoming_files, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :incoming_files, :nack_file_name, :string, :limit => 255, :comment => 'the name of the nack file'
    change_column :cn_incoming_files, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :cn_incoming_files, :rej_file_name, :string, :limit => 50, :comment => 'the name of the rej file'
    change_column :cn_incoming_files, :cnb_file_name, :string, :limit => 50, :comment => 'the name of the cnb file'
    change_column :ft_incoming_files, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :su_incoming_files, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :ic_incoming_files, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :pc_mm_cd_incoming_files, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :outgoing_files, :file_name, :string, :limit => 50, :null => false, :comment => 'the name of the file'
    change_column :outgoing_files, :file_path, :string, :limit => 50, :null => false, :comment => 'the path of the file'
    change_column :cn_incoming_records, :file_name, :string, :limit => 50, :comment => 'the name of the cnb file'
    change_column :ft_incoming_records, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :su_incoming_records, :file_name, :string, :limit => 50, :comment => 'the name of the file'
    change_column :ic_incoming_records, :file_name, :string, :limit => 50, :null => false, :comment => 'the name of the file'
    change_column :pc_mm_cd_incoming_records, :file_name, :string, :limit => 50, :comment => 'the name of the file'
  end
end
