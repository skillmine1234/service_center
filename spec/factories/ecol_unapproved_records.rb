# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ecol_unapproved_record do
    ecol_approvable_id 1
    ecol_approvable_type "MyString"
  end
end
