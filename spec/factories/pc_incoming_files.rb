# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_mm_cd_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'MMCD',:service_name => 'PPC')).id}
    file_name {Factory(:incoming_file).file_name}
    req_reference_no '1234'
    rep_reference_no '4321'
    mobile_no '9876543211'
    transfer_amount 2000
    rep_text 'reply'
    crdr 'C'
  end
end