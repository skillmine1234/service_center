# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cn_unapproved_record do
    cn_approvable_id 1
    cn_approvable_type "MyString"
  end
end
