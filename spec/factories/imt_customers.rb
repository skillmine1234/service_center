FactoryGirl.define do
  factory :imt_customer do
    customer_code "1234567890"
    customer_name "MyString"
    contact_person "MyString"
    email_id "MyString"
    account_no "0987654321"
    mobile_no "0987654321"
    expiry_period 1
    txn_mode "A"
    address_line1 "MyString"
    address_line2 "MyString"
  end
end