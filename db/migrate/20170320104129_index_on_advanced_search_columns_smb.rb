class IndexOnAdvancedSearchColumnsSmb < ActiveRecord::Migration
  def change
    add_index :sm_payments, [:customer_id, :req_no, :attempt_no, :status_code, :transfer_type, :partner_code,
                             :debit_account_no, :rmtr_account_no, :rmtr_account_ifsc, :bene_account_no, :bank_ref_no, 
                             :req_timestamp, :rep_timestamp], name: 'SM_PAYMENTS_03'
  end
end
