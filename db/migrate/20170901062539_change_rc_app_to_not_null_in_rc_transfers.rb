class ChangeRcAppToNotNullInRcTransfers < ActiveRecord::Migration
  def change
    change_column :rc_transfers, :rc_app_id, :integer, null: true
  end
end
