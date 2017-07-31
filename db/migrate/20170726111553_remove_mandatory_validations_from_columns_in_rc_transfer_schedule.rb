class RemoveMandatoryValidationsFromColumnsInRcTransferSchedule < ActiveRecord::Migration
  def change
    change_column :rc_transfer_schedule, :acct_threshold_amt, :number, null: true, default: nil
    change_column :rc_transfer_schedule, :bene_account_ifsc, :string, null: true, default: nil
  end
end
