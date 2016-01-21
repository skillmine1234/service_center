class AddIndexOnBillerAcctNoAndCustomerIdAndStatusCodeToBmAddBillerAccts < ActiveRecord::Migration
  def change
    add_index :bm_add_biller_accts, [:biller_acct_no, :customer_id, :status_code], name: 'idx_by_ban_cid_sc'
  end
end
