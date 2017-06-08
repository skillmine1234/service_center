# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fcr_cust_acct, class: Fcr::CustomerAccount do
    sequence(:cod_acct_no) {|n| "abcd0" + "%06i" % "#{n}" }
  end
end