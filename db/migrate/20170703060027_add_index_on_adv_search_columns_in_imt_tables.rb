class AddIndexOnAdvSearchColumnsInImtTables < ActiveRecord::Migration
  def change
    add_index :imt_add_beneficiaries, [:customer_id, :app_id, :req_no, :attempt_no, :status_code, :req_timestamp, :rep_timestamp], name: 'imt_add_beneficiaries_01'
    add_index :imt_del_beneficiaries, [:customer_id, :app_id, :req_no, :attempt_no, :status_code, :req_timestamp, :rep_timestamp], name: 'imt_del_beneficiaries_01'
    add_index :imt_initiate_transfers, [:customer_id, :app_id, :req_no, :attempt_no, :status_code, :req_timestamp, :rep_timestamp], name: 'imt_initiate_transfers_01'
    add_index :imt_cancel_transfers, [:customer_id, :app_id, :req_no, :attempt_no, :status_code, :req_timestamp, :rep_timestamp], name: 'imt_cancel_transfers_01'
    add_index :imt_resend_otp, [:customer_id, :app_id, :req_no, :attempt_no, :status_code, :req_timestamp, :rep_timestamp], name: 'imt_resend_otp_01'
  end
end
