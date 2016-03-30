# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :su_customer do
    account_no "1234567890"
    sequence(:customer_id) {|n| "9" + "%03i" % "#{n}" }
    pool_account_no "MyString"
    pool_customer_id "MyString"
    is_enabled "N"
    approval_status "U"
    last_action "C"
  end
end