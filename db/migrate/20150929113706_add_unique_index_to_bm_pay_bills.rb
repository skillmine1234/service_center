class AddUniqueIndexToBmPayBills < ActiveRecord::Migration
  def change
    add_index :bm_pay_bills, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_pay_bills"
  end
end
