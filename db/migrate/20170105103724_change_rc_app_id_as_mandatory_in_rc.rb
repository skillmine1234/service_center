class ChangeRcAppIdAsMandatoryInRc < ActiveRecord::Migration
  def change
    RcTransferSchedule.unscoped.update_all(rc_app_id: 10000)
    RcTransfer.update_all(rc_app_id: 10000)
    change_column :rc_transfer_schedule, :rc_app_id, :integer, null: false
    change_column :rc_transfers, :rc_app_id, :integer, null: false
  end
end
