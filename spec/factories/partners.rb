# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :partner do
    code "MyString"
    name "MyString"
    tech_email_id "MyString"
    ops_email_id "MyString"
    account_no "1234567890123456"
    account_ifsc "abcd0123456"
    txn_hold_period_days 1
    identity_user_id "MyString"
    low_balance_alert_at 1.5
    remitter_sms_allowed "MyString"
    remitter_email_allowed "MyString"
    beneficiary_sms_allowed "MyString"
    beneficiary_email_allowed "MyString"
    allow_neft "MyString"
    allow_rtgs "MyString"
    allow_imps "MyString"
    created_by "MyString"
    updated_by "MyString"
  end
end
