# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic_unapproved_record do
    ic_approvable_id 1
    ic_approvable_type "MyString"
  end
end
