# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :whitelisted_identity do
    partner_id 1
    full_name "Foo Bar"
    first_name "Foo"
    last_name "Bar"
    id_type "Passport"
    id_number "G12424"
    id_country "India"
    id_issue_date "2015-04-20"
    id_expiry_date "2040-05-19"
    is_verified "Y"
    verified_at "2015-04-20"
    verified_by {Factory(:user).id}
    first_used_with_txn_id 1
    last_used_with_txn_id 1
    times_used 1
    created_by {Factory(:user).id}
    updated_by {Factory(:user).id}
    lock_version 1
  end
end
