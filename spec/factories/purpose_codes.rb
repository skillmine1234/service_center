# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purpose_code do
    code "MyString"
    description "MyString"
    is_enabled "MyString"
    created_by ""
    updated_by "MyString"
    lock_version 1.5
    txn_limit 1.5
    daily_txn_limit 1.5
    disallowedremtypes "MyString"
    disallowedbenetypes "MyString"
  end
end
