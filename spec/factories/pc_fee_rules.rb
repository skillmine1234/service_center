# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_fee_rule do
    app_id {Factory(:pc_app, :approval_status => 'A').app_id}
    txn_kind "LC"
    no_of_tiers 1
    approval_status "U"
  end
end
