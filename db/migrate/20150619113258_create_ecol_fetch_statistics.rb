class CreateEcolFetchStatistics < ActiveRecord::Migration
  def change
    create_table :ecol_fetch_statistics do |t|
      t.datetime :last_neft_at
      t.integer :last_neft_id
      t.integer :last_neft_cnt
      t.integer :tot_neft_cnt
      t.datetime :last_rtgs_at
      t.integer :last_rtgs_id
      t.integer :last_rtgs_cnt
      t.integer :tot_rtgs_cnt
    end
  end
end
