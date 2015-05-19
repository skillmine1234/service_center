# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rule do
    pattern_individuals "MyString"
    pattern_corporates "MyString"
    pattern_beneficiaries "MyString"
  end
end
