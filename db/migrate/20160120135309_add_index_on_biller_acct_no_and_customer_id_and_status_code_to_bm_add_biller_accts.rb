class AddIndexOnBillerAcctNoAndCustomerIdAndStatusCodeToBmAddBillerAccts < ActiveRecord::Migration
  def change
    add_index :bm_add_biller_accts, [:biller_acct_no, :customer_id, :status_code], :unique => true, :name => "index_on_ban_and_cid_and_sc"
  end
end
