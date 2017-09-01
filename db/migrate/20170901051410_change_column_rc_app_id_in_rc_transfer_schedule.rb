class ChangeColumnRcAppIdInRcTransferSchedule < ActiveRecord::Migration
  def change
    change_column :rc_transfer_schedule, :rc_app_id, :integer, null: true
    change_column :rc_transfer_schedule, :app_code, :string, null: true
  end
end
