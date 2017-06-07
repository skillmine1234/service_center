# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fcr_customer, class: Fcr::Customer do
    sequence(:cod_cust_id) {|n| "abcd0" + "%06i" % "#{n}" }
  end
end