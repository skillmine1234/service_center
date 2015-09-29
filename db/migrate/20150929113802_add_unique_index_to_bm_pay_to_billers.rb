class AddUniqueIndexToBmPayToBillers < ActiveRecord::Migration
  def change
    add_index :bm_pay_to_billers, [:app_id, :req_no, :attempt_no], :unique => true, :name => "attempt_no_index_pay_billers"
  end
end
