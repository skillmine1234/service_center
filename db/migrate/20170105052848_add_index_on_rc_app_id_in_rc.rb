class AddIndexOnRcAppIdInRc < ActiveRecord::Migration
  def change
    add_index :rc_transfer_schedule, :rc_app_id
    add_index :rc_transfers, :rc_app_id
  end
end
