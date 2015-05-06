# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    remittance_req_no "MyString"
    id_req_type "MyString"
    partner_id ""
    full_name "MyString"
    first_name "MyString"
    last_name "MyString"
    id_type "MyString"
    id_number "MyString"
    id_country "MyString"
    id_issue_date "2015-04-29"
    id_expiry_date "2015-04-29"
    is_verified "MyString"
    verified_at "2015-04-29"
    verified_by "MyString"
    created_by "MyString"
    updated_by "MyString"
    lock_version 1
  end
end
