class ChangeRcAppIdAsMandatoryInRc < ActiveRecord::Migration
  def change
    change_column :rc_transfer_schedule, :rc_app_id, :integer, null: false
    change_column :rc_transfers, :rc_app_id, :integer, null: false
  end
end
