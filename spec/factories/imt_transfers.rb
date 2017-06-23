FactoryGirl.define do
  factory :imt_transfer do
    app_id "MyString"
    imt_ref_no "MyString"
    status_code "MyString"
    customer_id "MyString"
    bene_mobile_no "MyString"
    transfer_amount 1000
    rmtr_to_bene_note "MyString"
    initiation_ref_no "MyString"
    initiation_bank_ref "MyString"
  end
end