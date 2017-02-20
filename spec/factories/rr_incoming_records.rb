# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rr_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'RR',:service_name => 'RR')).id}
    file_name 'file'
    txn_type 'IMPS'
    bank_ref_no '12345'
    settlement_date Date.today
    reason 'Reason'
  end
end
