class AddColumnsToPurposeCodes < ActiveRecord::Migration
  def change
    add_column :purpose_codes, :mtd_txn_cnt_self, :integer
    add_column :purpose_codes, :mtd_txn_limit_self, :decimal
    add_column :purpose_codes, :mtd_txn_cnt_sp, :integer
    add_column :purpose_codes, :mtd_txn_limit_sp, :decimal
    add_column :purpose_codes, :rbi_code, :string, :limit => 5
  end
end
