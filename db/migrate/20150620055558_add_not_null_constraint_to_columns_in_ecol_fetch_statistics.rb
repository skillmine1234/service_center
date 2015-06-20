class AddNotNullConstraintToColumnsInEcolFetchStatistics < ActiveRecord::Migration
  def change
    change_column :ecol_fetch_statistics, :last_neft_at, :datetime,  null: false
    change_column :ecol_fetch_statistics, :last_neft_id, :integer, null: false
    change_column :ecol_fetch_statistics, :last_neft_cnt, :integer, null: false
    change_column :ecol_fetch_statistics, :tot_neft_cnt, :integer, null: false
    change_column :ecol_fetch_statistics, :last_rtgs_at, :datetime,  null: false
    change_column :ecol_fetch_statistics, :last_rtgs_id, :integer, null: false
    change_column :ecol_fetch_statistics, :last_rtgs_cnt, :integer, null: false
    change_column :ecol_fetch_statistics, :tot_rtgs_cnt, :integer, null: false
  end
end
