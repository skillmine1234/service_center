class AddIntervalToOutgoingFileTypes < ActiveRecord::Migration
  def change
    add_column :outgoing_file_types, :run_at_hour, :int, :comment => "the hour of the day when the file shoud be created (0-23)"
    add_column :outgoing_file_types, :run_at_day, :string, :limit => 1, :comment => "the day of the month when the file should be created (1-31), D for daily, L for last day of the month"
    add_column :outgoing_file_types, :last_run_at, :datetime, :comment => "the datetime when the file was last created"
    add_column :outgoing_file_types, :next_run_at, :datetime, :comment => "the datetime when the file will next be created"
    add_column :outgoing_file_types, :batch_size, :int, :comment => "the batch size to be used for writing to the file"
    add_column :outgoing_file_types, :write_header, :string, :limit => 1, :comment => "the flag that indicates if the extract needs a header to be written"
    add_column :outgoing_file_types, :email_to, :string, :comment => "the comma separated list of addresses to which the email is to be sent"
    add_column :outgoing_file_types, :email_cc, :string, :comment => "the comma separated list of addresses which will be cc'd"
    add_column :outgoing_file_types, :email_subject, :string, :comment => "the subject of the email"

  end
end
