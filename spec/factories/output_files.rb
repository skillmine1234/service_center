# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fm_output_file do
    sequence(:file_name) { |n| "file#{n}" }
    incoming_file_id { Factory(:incoming_file, approval_status: 'A').id }
    step_name 'UPLOAD'
    status_code 'COMPLETED'
    started_at "2015-06-15"
    ended_at "2015-06-15"
  end
end
