# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_unapproved_record do
    pc_approvable_id 1
    pc_approvable_type "MyString"
  end
end
