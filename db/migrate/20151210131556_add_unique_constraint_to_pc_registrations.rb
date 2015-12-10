class AddUniqueConstraintToPcRegistrations < ActiveRecord::Migration
  def change
    add_index :pc_registrations, [:req_no, :app_id, :attempt_no], :unique => true
  end
end
