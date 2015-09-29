class AddUniqueIndexToBmAddBillerAccts < ActiveRecord::Migration
  def change
    add_index :bm_add_biller_accts, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_add_accts"
  end
end
