# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc2_unapproved_record do
    pc2_approvable_id 1
    pc2_approvable_type "MyString"
  end
end
