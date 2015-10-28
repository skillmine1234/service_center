class RemoveTableBmTopUps < ActiveRecord::Migration
  def change
    drop_table :bm_top_ups
  end
end
