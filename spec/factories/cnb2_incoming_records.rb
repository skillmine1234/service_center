# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cnb2_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'CNB',:service_name => 'CNB')).id}
    file_name 'file'
    run_date '12-Feb-2017'
    add_identification '1234'
    pay_comp_code '4321'
    doc_no 'D123'
    amount '12.2'
    currency 'Rs'
    pay_method 'DD'
    vendor_code 'V1234'
    payee_title 'MR'
    payee_name 'Foo'
    payee_addr1 'ADDR1'
    payee_addr2 'ADDR2'
    payee_addr3 'ADDR3'
    payee_addr4 'ADDR4'
    payee_addr5 'ADDR5'
    house_bank 'BANK1'
    acct_dtl_id 1234
    value_date '12-March-2017'
    system_date '12-March-2017'
    delivery_mode 'DD'
    cheque_no '75657567'
    pay_location 'ASD'
    bene_account_no '4653657547'
    ifsc_code 'asdf0435453'
    bank_name 'ABCD'
    bene_email_id 'abcd@gmail.com'
    bene_email_id_2 'dcba@gmail.com'
  end
end
