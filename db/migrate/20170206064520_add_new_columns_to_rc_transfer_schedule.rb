class AddNewColumnsToRcTransferSchedule < ActiveRecord::Migration
  def change
    add_column :rc_transfer_schedule, :txn_kind, :string, limit: 20, null: false, default: 'FT', comment: 'the txn kind, one of FT, BALINQ'
    add_column :rc_transfer_schedule, :interval_in_mins, :integer, null: false, default: 5, comment: 'the interval in minutes for retry'
  end
end
