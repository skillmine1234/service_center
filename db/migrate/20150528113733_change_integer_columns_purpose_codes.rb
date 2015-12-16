class ChangeIntegerColumnsPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :txn_limit, :float, :precision => 0
    change_column :purpose_codes, :mtd_txn_cnt_self, :float, :precision => 0
    change_column :purpose_codes, :mtd_txn_cnt_sp, :float, :precision => 0
  end
end
