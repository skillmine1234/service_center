class ChangeIndexInRcTransfers < ActiveRecord::Migration
  def change
    remove_index :rc_transfers, name: 'rc_transfers_02'
    remove_index :rc_transfers, name: 'rc_transfers_03'
    add_index :rc_transfers, [:status_code, :notify_status, :rc_app_id, :app_code, :broker_uuid], name: 'rc_transfers_02'
  end
end
