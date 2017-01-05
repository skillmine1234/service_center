class ChangeNotifyMobileNoToNullableInRcTransferSchedules < ActiveRecord::Migration
  def change
    change_column :rc_transfer_schedule, :notify_mobile_no, :string, null: true
  end
end
