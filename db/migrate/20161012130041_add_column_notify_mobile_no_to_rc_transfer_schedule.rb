class AddColumnNotifyMobileNoToRcTransferSchedule < ActiveRecord::Migration
  def change
    add_column :rc_transfer_schedule, :notify_mobile_no, :string, :limit => 10, :comment => 'the mobile no that will be notified'
    db.execute "UPDATE rc_transfer_schedule SET notify_mobile_no = '0'"
    change_column :rc_transfer_schedule, :notify_mobile_no, :string, :limit => 10, :null => false, :comment => 'the mobile no that will be notified'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
