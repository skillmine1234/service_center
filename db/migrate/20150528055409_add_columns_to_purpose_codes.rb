class AddColumnsToPurposeCodes < ActiveRecord::Migration
  def change
    add_column :purpose_codes, :mtd_txn_cnt_self, :integer
    add_column :purpose_codes, :mtd_txn_limit_self, :float
    add_column :purpose_codes, :mtd_txn_cnt_sp, :integer
    add_column :purpose_codes, :mtd_txn_limit_sp, :float
    add_column :purpose_codes, :rbi_code, :string, :limit => 5
  end
end
