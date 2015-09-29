class AddUniqueIndexToBmPayToBillerAccts < ActiveRecord::Migration
  def change
    add_index :bm_pay_to_biller_accts, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_biller_acct"
  end
end
