# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ssp_bank do
    app_code 'APP12'
    debit_account_url 'http://localhost:3000'
    reverse_debit_account_url 'http://localhost:3000'
    get_status_url 'http://localhost:3000'
    get_account_status_url 'http://localhost:3000'
    sequence(:customer_code) {|n| "%03i" % "#{n}"}
    setting1_name 'udf1'
    setting1_type 'number'
    setting1_value '1234'
    approval_status "U"
    last_action "C"
    lock_version 1
    approved_version 1
  end
end