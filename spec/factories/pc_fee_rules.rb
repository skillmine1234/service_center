# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_fee_rule do
    program_code {Factory(:pc_program, :approval_status => 'A').code}
    txn_kind "LC"
    no_of_tiers 1
    tier1_to_amt 1000
    tier1_method "F"
    tier1_fixed_amt 1500
    tier1_pct_value 12
    tier1_min_sc_amt 2000
    tier1_max_sc_amt 2000
    approval_status "U"
  end
end
