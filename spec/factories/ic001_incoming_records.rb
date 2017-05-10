# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic001_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'IC_001',:service_name => 'INSTANTCREDIT')).id}
    file_name 'file'
  end
end
