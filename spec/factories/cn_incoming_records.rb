# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cn_incoming_record do
    incoming_file_record_id 1
    # incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'CNB',:service_name => 'CNB')).id}
    file_name '1_EcolTransaction.csv'
    message_type 'Payment'
    transaction_ref_no 12345
    debit_account_no "123456789"
    amount 2000
    rmtr_name 'Foo Bar'
    rmtr_address1 'address1'
    rmtr_address2 'address2'
    rmtr_address3 'address3'
    rmtr_address4 'address4'
    bene_ifsc_code '13432FV'
    bene_account_no "123456789"
    bene_name 'Foo Bar'
    bene_add_line1 'address1'
    bene_add_line2 'address2'
    bene_add_line3 'address3'
    bene_add_line4 'address4'
    upload_date Date.today
    rmtr_to_bene_note 'Note'
  end
end
