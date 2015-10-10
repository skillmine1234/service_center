# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pending_inward_remittance do
    inward_remittance_id 1
    broker_uuid "MyString"
  end
end
