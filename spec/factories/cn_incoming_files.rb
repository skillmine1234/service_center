# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cn_incoming_file do
    file_name {Factory(:incoming_file).file_name}
    batch_no 1
    rej_file_name 'File1'
    rej_file_path '/public'
    rej_file_status 'C'
    cnb_file_name 'File2'
    cnb_file_path '/public'
    cnb_file_status 'C'
  end
end
