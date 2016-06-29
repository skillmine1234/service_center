# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sm_bank do
    sequence(:code) {|n| "%04i" % "#{n}"}
    name "Foo"
    bank_code "abcd0123456"
    low_balance_alert_at 0
    identity_user_id "MyString"
    neft_allowed "N"
    imps_allowed "Y"
    created_by {Factory(:user).id}
    updated_by {Factory(:user).id}
    lock_version 1
    approval_status "U"
    last_action "C"
    approved_version 1
    is_enabled "Y"
  end
end