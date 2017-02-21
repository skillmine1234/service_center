FactoryGirl.define do
  factory :reconciled_return do
    txn_type "NEFT"
    return_code_type "COMPLETED"
    return_code "75"
    settlement_date "2015-12-12"
    sequence(:bank_ref_no) {|n| "%03i" % "#{n}"}
    reason "MyString"
    created_by "MyString"
    updated_by "MyString"
    last_action 1
  end
end