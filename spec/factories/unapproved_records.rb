# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unapproved_record do
    approvable_id 1
    approvable_type "MyString"
  end
end