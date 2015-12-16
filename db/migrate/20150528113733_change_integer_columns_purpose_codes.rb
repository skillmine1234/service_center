class ChangeIntegerColumnsPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :txn_limit, :number
    change_column :purpose_codes, :mtd_txn_cnt_self, :number
    change_column :purpose_codes, :mtd_txn_cnt_sp, :number
  end
end
