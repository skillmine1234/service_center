class ChangeIntegerColumnsPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :txn_limit, :decimal, :precision => 0
    change_column :purpose_codes, :mtd_txn_cnt_self, :decimal, :precision => 0
    change_column :purpose_codes, :mtd_txn_cnt_sp, :decimal, :precision => 0
  end
end
