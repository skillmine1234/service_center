# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ecol_customer do
    code "CUST00"
    name "MyString"
    is_enabled "Y"
    val_method "D"
    token_1_type "N"
    token_1_length 0
    val_token_1 "N"
    token_2_type "RC"
    token_2_length 0
    val_token_2 "N"
    token_3_type "IN"
    token_3_length 0
    val_token_3 "N"
    val_txn_date "N"
    val_txn_amt "N"
    val_ben_name "N"
    val_rem_acct "N"
    return_if_val_fails "N"
    file_upld_mthd "I"
    credit_acct_no "1234567890"
    nrtv_sufx_1 "N"
    nrtv_sufx_2 "N"
    nrtv_sufx_3 "N"
    rmtr_alert_on "N"
    rmtr_pass_txt "MyString"
    rmtr_return_txt "MyString"
  end
end
