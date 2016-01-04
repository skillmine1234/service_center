# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pcs_top_up do
    req_no "MyString"
    attempt_no 1
    status_code "MyString"
    req_version "MyString"
    req_timestamp "2016-01-04 08:08:27"
    app_id "MyString"
    mobile_no "MyString"
    encrypted_pin "MyString"
    biller_id "MyString"
    subscriber_id "MyString"
    transfer_amount 1.5
    rep_no "MyString"
    rep_version "MyString"
    rep_timestamp "2016-01-04 08:08:27"
    service_charge 1.5
    txn_uid "MyString"
    debit_ref_no "MyString"
    biller_ref_no "MyString"
    debit_fee_status "MyString"
    debit_fee_result "MyString"
    fault_code "MyString"
    fault_reason "MyString"
  end
end
