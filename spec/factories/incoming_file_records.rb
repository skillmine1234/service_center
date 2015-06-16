# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incoming_file_record do
    incoming_file_id 1
    record_no 1
    record_txt "MyText"
    status "MyString"
    fault_code "MyString"
    fault_reason "MyString"
  end
end
