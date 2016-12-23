class CreateIncomingRejFiles < ActiveRecord::Migration
  def change
    create_table :incoming_rej_files, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.date :started_at, :comment => "the date at which the file processing started"
      t.date :ended_at, :comment => "the date at which the file processing ended"
      t.datetime :alert_at, :comment => "the timestamp when the alert is sent"
      t.string :alert_ref, :limit => 50, :comment => "the unique no which is being sent to email server"
      t.string :file_name, :limit => 100, :comment => "the name of the file"
      t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_subcode, :limit => 50, :comment => "the error code that the third party will return"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.index([:alert_ref], :unique => true, :name => 'incoming_rej_files_01')
    end
  end
end
