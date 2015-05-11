# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inward_remittance do
    req_no "MyString"
    req_version "MyString"
    req_timestamp "2015-04-20 15:12:44"
    partner_code "MyString"
    rmtr_full_name "MyString"
    rmtr_first_name "MyString"
    rmtr_last_name "MyString"
    rmtr_address1 "MyString"
    rmtr_address2 "MyString"
    rmtr_address3 "MyString"
    rmtr_postal_code "MyString"
    rmtr_city "MyString"
    rmtr_state "MyString"
    rmtr_country "MyString"
    rmtr_email_id "MyString"
    rmtr_mobile_no "MyString"
    rmtr_identity_count 1
    bene_full_name "MyString"
    bene_first_name "MyString"
    bene_last_name "MyString"
    bene_address1 "MyString"
    bene_address2 "MyString"
    bene_address3 "MyString"
    bene_postal_code "MyString"
    bene_city "MyString"
    bene_state "MyString"
    bene_country "MyString"
    bene_email_id "MyString"
    bene_mobile_no "MyString"
    bene_identity_count 1
    bene_account_no "MyString"
    bene_account_ifsc "MyString"
    transfer_type "MyString"
    transfer_ccy "MyString"
    transfer_amount 1.5
    rmtr_to_bene_note "MyString"
    purpose_code "MyString"
    status_code "MyString"
    bank_ref "MyString"
    bene_ref "MyString"
    rep_no "MyString"
    rep_version "MyString"
    rep_timestamp "2015-04-20 15:12:44"
    review_reqd "MyString"
    review_pending "MyString"
    attempt_no 1.5
  end
end
