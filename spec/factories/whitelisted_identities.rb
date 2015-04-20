# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :whitelisted_identity do
    partner_id 1
    full_name "MyString"
    first_name "MyString"
    last_name "MyString"
    id_type "MyString"
    id_number "MyString"
    id_country "MyString"
    id_issue_date "2015-04-20"
    is_verified "MyString"
    verified_at "2015-04-20"
    verified_by "MyString"
    first_used_with_txn_id 1
    last_used_with_txn_id 1
    times_used 1
    created_by "MyString"
    updated_by "MyString"
    lock_version 1
  end
end
