# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :funds_transfer_customer do
    name "MyString"
    account_no "1234567890"
    account_ifsc "ASDF0123456"
    low_balance_alert_at 123
    identity_user_id "1"
    customer_id "MyString"
    mobile_no "9876543210"
    approval_status "U"
    allow_neft "N"
    allow_imps "N"
    enabled "N"
  end
end
