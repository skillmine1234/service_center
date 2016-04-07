# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc2_app do
    sequence(:app_id) {|n| "9" + "%03i" % "#{n}" }
    customer_id "MyString"
    is_enabled "Y"
    identity_user_id "MyString"
    approval_status "U"
  end
end
