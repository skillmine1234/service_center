class AddOverridenRecordCountToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :overriden_record_count, :integer, :comment => "the count of records with status overriden"
  end
end
