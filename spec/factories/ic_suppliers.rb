# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic_supplier do
    sequence(:supplier_code) {|n| "9" + "%03i" % "#{n}" }
    sequence(:customer_id) {|n| "8" + "%03i" % "#{n}" }
    corp_customer_id {Factory(:ic_customer, :approval_status => 'A').customer_id}
    supplier_name "MyString"
    od_account_no "1234567890"
    ca_account_no "2345678901"
    is_enabled "N"
    approval_status "U"
    last_action "C"
  end
end
