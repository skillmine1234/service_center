# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_app do
    sequence(:app_id) {|n| "9" + "%03i" % "#{n}" }
    card_acct "MyString"
    sc_gl_income "MyString"
    is_enabled "N"
    approval_status "U"
    card_cust_id "2424"
    traceid_prefix 1
    source_id "MyString"
    channel_id "MyString"
    mm_host "http://localhost:3000/pc_apps"
    mm_consumer_key "MyString"
    mm_consumer_secret "MyString"
    mm_card_type "MyString"
    mm_email_domain "MyString"
    mm_admin_host "MyString"
    mm_admin_user "MyString"
    mm_admin_password "MyString"
  end
end
