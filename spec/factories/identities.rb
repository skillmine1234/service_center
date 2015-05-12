# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inw_identity do
    remittance_req_no {Factory(:inward_remittance).id}
    id_req_type "Remitter"
    partner_id {Factory(:partner).id}
    full_name "Foo Bar"
    first_name "Foo"
    last_name "Bar"
    id_type "Passport"
    id_number "G12424"
    id_country "India"
    id_issue_date "2015-04-20"
    id_expiry_date "2040-05-19"
    created_by "MyString"
    updated_by "MyString"
    lock_version 1
  end
end
