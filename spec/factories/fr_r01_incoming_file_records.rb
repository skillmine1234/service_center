# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fr_r01_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'R01',:service_name => 'FR')).id}
    file_name 'file'
    account_no '1234567890'
    available_balance 1000
    onhold_amount 100
    sweepin_balance 100
    overdraft_limit 0
    total_balance 2000
    customer_name 'MyString'
  end
end
