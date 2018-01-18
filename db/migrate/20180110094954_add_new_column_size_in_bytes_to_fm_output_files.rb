class AddNewColumnSizeInBytesToFmOutputFiles < ActiveRecord::Migration
  def change
    add_column :fm_output_files, :size_in_bytes, :integer, comment: 'the size of the response file in bytes' 
  end
end
