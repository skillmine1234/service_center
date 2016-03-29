class CreatePendingIncomingFiles < ActiveRecord::Migration
  def change
    create_table :pending_incoming_files , {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string   :broker_uuid, :comment => "the uuid of the broker that will process the file"
      t.string   :incoming_file_id, :comment => "the foreign key to the incoming_files table"
      t.datetime :created_at,  :comment => "the timestamp when this record was created"
    end
  end
end
