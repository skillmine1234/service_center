class AddColumnRcScheduleIdToRcPendingTransfers < ActiveRecord::Migration
  def change
    add_column :rc_pending_schedules, :rc_schedule_id, :integer, :comment => "the id of the row that represents the schedule that is related to this record"
    db.execute "UPDATE rc_pending_schedules SET rc_schedule_id = 0"
    change_column :rc_pending_schedules, :rc_schedule_id, :integer, :null => false, :comment => "the id of the row that represents the schedule that is related to this record"    
  end
  def db
    ActiveRecord::Base.connection
  end  
end
