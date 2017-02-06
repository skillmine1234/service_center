class AddColumnsToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :txn_kind, :string, limit: 20, null: false, default: 'FT', comment: 'the txn kind, one of FT, BALINQ'
  end
end
