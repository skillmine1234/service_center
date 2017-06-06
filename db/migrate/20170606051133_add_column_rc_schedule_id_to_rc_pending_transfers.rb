class AddColumnRcScheduleIdToRcPendingTransfers < ActiveRecord::Migration
  def change
    add_column :rc_pending_schedules, :rc_schedule_id, :integer, :null => false, :comment => "the id of the row that represents the schedule that is related to this record" 
  end
end
