class AddColumnNotifyMobileNoToRcTransferSchedule < ActiveRecord::Migration
  def change
    add_column :rc_transfer_schedule, :notify_mobile_no, :string, :limit => 10, :comment => 'the mobile no that will be notified'
  end
end
