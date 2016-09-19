FactoryGirl.define do
  factory :reconciled_return do
    txn_type "MyString"
    return_code "MyString"
    settlement_date "2015-12-12"
    bank_ref_no "MyString"
    reason "MyString"
    created_by "MyString"
    updated_by "MyString"
    last_action 1
  end
end