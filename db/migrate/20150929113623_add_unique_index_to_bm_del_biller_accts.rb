class AddUniqueIndexToBmDelBillerAccts < ActiveRecord::Migration
  def change
    add_index :bm_del_biller_accts, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_del_accts"
  end
end
