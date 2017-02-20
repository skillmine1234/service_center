# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rr_unapproved_record do
    rr_approvable_id 1
    rr_approvable_type "MyString"
  end
end
