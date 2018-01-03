class AddNewColumnsToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :max_file_size, :number, :comment => "the maximum allowed size for this file type"
    add_column :incoming_file_types, :finish_each_file, :string, null: false, limit: 1, default: 'N', comment: 'the identifier to specify whether to call finish_fie after each step or after all steps are done, for each file'
  end
end
