# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bank do
    ifsc "MyString"
    name "MyString"
    imps_enabled false
  end
end
