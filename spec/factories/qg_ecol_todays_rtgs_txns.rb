# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :qg_ecol_todays_rtgs_txn do
    idfcatref "MyString"
    transfer_type "MyString"
    transfer_status "MyString"
    transfer_unique_no "MyString"
    rmtr_ref "MyString"
    bene_account_ifsc "ASDF0123456"
    bene_account_no "MyString"
    bene_account_type "MyString"
    rmtr_account_ifsc "ASDF0123456"
    rmtr_account_no "MyString"
    rmtr_account_type "MyString"
    transfer_amt 500000
    transfer_ccy "MyString"
    transfer_date "2016-01-11 04:42:15"
    rmtr_to_bene_note "MyString"
    rmtr_full_name "MyString"
    rmtr_address "MyString"
    bene_full_name "MyString"
  end
end
