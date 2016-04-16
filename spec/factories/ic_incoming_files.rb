# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic_incoming_file do
    file_name {Factory(:incoming_file).file_name}
    corp_customer_id "12345"
    pm_utr "DF123"
  end
end