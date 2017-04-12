class AddIndexInRcTransfers < ActiveRecord::Migration
  def change
    add_index :rc_transfers, :status_code, name: 'rc_transfers_02'
    add_index :rc_transfers, [:status_code, :notify_status, :rc_app_id, :app_code], name: 'rc_transfers_03'
  end
end
