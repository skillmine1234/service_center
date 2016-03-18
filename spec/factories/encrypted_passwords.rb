# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :encrypted_password do
    created_by 1
    password "MyString"
  end
end
