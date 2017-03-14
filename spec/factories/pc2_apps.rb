# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc2_app do
    sequence(:app_id) {|n| "9" + "%03i" % "#{n}" }
    customer_id 9898
    is_enabled "Y"
    identity_user_id { Factory(:iam_cust_user, approval_status: 'A').username }
    approval_status "U"
  end
end
