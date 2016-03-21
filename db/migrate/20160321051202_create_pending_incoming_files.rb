class CreatePendingIncomingFiles < ActiveRecord::Migration
  def change
    create_table :pending_incoming_files do |t|
      t.string   :broker_uuid, :comment => "the broker uuid of the machine"
      t.string   :incoming_file_id, :comment => "the id of the incomoing file"
      t.datetime :created_at,  :comment => "the created date and time of the file "
    end
  end
end
