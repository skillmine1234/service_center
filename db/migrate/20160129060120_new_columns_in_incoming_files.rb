class NewColumnsInIncomingFiles < ActiveRecord::Migration
  def change
    change_column :incoming_files, :service_name, :string, :limit => 10, :comment => "the name of the service to which this file belongs to"
    change_column :incoming_files, :file_type, :string, :limit => 10, :comment => "the type of the file basis upon the data that it contains"
    change_column :incoming_files, :file_name, :string, :limit => 50, :comment => "the name of the file"
    change_column :incoming_files, :size_in_bytes, :integer, :comment => "the size of the file in bytes"
    change_column :incoming_files, :line_count, :integer, :comment => "the no. of lines in the file"
    change_column :incoming_files, :status, :string, :limit => 1, :comment => "the current status of the file"
    change_column :incoming_files, :started_at, :date, :comment => "the date at which the file processing started"
    change_column :incoming_files, :ended_at, :date, :comment => "the date at which the file processing ended"
    change_column :incoming_files, :created_by, :string, :limit => 20, :comment => "the id of the user who added this file"
    change_column :incoming_files, :updated_by, :string, :limit => 20, :comment => "the id of the user who updated this file"
    change_column :incoming_files, :fault_code, :string, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
    change_column :incoming_files, :fault_reason, :string, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
    change_column :incoming_files, :updated_at, :datetime, :null => true
    add_column :incoming_files, :broker_uuid, :string, :limit => 255, :comment => "the uuid of the broker that processed the file"
    add_column :incoming_files, :failed_record_count, :integer, :comment => "the count of records that failed"
    add_column :incoming_files, :fault_subcode, :string, :limit => 50, :comment => "the error code that the third party will return"
  end
end
