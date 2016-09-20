# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_card_registration do
    app_id {Factory(:pc_card_registration, :approval_status => 'A').app_id}
  end
end
