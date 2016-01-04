# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_app do
    sequence(:app_id) {|n| "9" + "%03i" % "#{n}" }
    card_acct "MyString"
    sc_gl_income "MyString"
    is_enabled "N"
    approval_status "U"
    card_cust_id "2424"
  end
end
