# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sc_unapproved_record do
    sc_approvable_id 1
    sc_approvable_type "MyString"
  end
end
