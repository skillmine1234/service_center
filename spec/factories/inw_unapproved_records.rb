# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inw_unapproved_record do
    inw_approvable_id 1
    inw_approvable_type "MyString"
  end
end