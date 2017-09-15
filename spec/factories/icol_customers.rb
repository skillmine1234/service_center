# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :icol_customer do
    app_code 'APP12'
    sequence(:customer_code) {|n| "%03i" % "#{n}"}
    setting1_name 'udf1'
    setting1_type 'number'
    setting1_value '1234'
    notify_url 'http://localhost'
    approval_status "U"
    last_action "C"
    lock_version 1
    approved_version 1
  end
end