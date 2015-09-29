class AddUniqueIndexToBmTopUps < ActiveRecord::Migration
  def change
    add_index :bm_top_ups, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_top_ups"
  end
end
