# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inw_identity do
    inw_remittance_id {Factory(:inward_remittance).id}
    id_for "Remitter"
    id_type "Passport"
    id_number "G12424"
    id_country "India"
    id_issue_date "2015-04-20"
    id_expiry_date "2040-05-19"
  end
end
