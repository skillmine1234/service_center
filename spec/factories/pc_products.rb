# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_product do
    sequence(:code) {|n| "%04i" % "#{n}"}
    mm_host "http://localhost:3000/pc_products"
    mm_consumer_key "MyString"
    mm_consumer_secret "MyString"
    mm_card_type "MyString"
    mm_email_domain "MyString"
    mm_admin_host "http://localhost:3000/pc_products"
    mm_admin_user "MyString"
    mm_admin_password "MyString"
    is_enabled "Y"
    created_by "MyString"
    updated_by "MyString"
    lock_version 0
    approval_status "U"
    last_action "MyString"
    card_acct "MyString12"
    sc_gl_income "MyString"
    cust_care_no "180012345678"
    rkb_user "user1"
    rkb_password "password1"
    rkb_bcagent "agent1"
    rkb_channel_partner "cp1"
  end
end
