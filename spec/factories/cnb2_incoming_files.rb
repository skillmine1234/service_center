# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cnb2_incoming_file do
    file_name {Factory(:incoming_file).file_name}
    account 1
    cnb_file_name 'File2'
    cnb_file_path '/public'
    cnb_file_status 'C'
  end
end
