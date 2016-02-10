class ChangeIntegerColumnsPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :txn_limit, :number, :precision => 0
    change_column :purpose_codes, :mtd_txn_cnt_self, :number, :precision => 0
    change_column :purpose_codes, :mtd_txn_cnt_sp, :number, :precision => 0
  end
end
