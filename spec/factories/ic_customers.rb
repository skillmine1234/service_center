# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic_customer do
    sequence(:customer_id) {|n| "9" + "%03i" % "#{n}" }
    sequence(:app_id) {|n| "8" + "%03i" % "#{n}" }
    sequence(:identity_user_id) {|n| "7" + "%03i" % "#{n}" }
    sequence(:repay_account_no) {|n| "6" + "%03i" % "#{n}" }
    fee_pct "9.99"
    fee_income_gl "123"
    max_overdue_pct "9.99"
    cust_contact_email "abc@ruby.com"
    cust_contact_mobile "9876543210"
    ops_email "def@ruby.com"
    rm_email "geh@ruby.com"
    is_enabled "N"
    approval_status "U"
    last_action "C"
  end
end
