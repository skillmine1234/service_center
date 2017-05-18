# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc2_cust_account do
    customer_id {Factory(:pc2_app, :is_enabled => 'Y', :approval_status => 'A').customer_id}
    sequence(:account_no) {|n| "9" + "%05i" % "#{n}"} 
    is_enabled 'Y'
    approval_status 'U'
  end
end
