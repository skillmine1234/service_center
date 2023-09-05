class AddColumnsToPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :purpose_codes, :mtd_txn_cnt_self, :integer
    add_column :purpose_codes, :mtd_txn_limit_self, :number
    add_column :purpose_codes, :mtd_txn_cnt_sp, :integer
    add_column :purpose_codes, :mtd_txn_limit_sp, :number
    add_column :purpose_codes, :rbi_code, :string, :limit => 5
  end
end
