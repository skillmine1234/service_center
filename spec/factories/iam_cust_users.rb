FactoryGirl.define do
  factory :iam_cust_user do
    sequence(:username) {|n| "%03i" % "#{n}"}
    first_name "MyString"
    mobile_no "9876543210"
    email "mystring@abc.com"
    approval_status "U"
    last_action "C"
    lock_version 1
    approved_version 1
  end
end