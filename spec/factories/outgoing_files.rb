FactoryGirl.define do
  factory :outgoing_file do
    service_code {Factory(:sc_service).code}
    file_type "abcd"
    file_path "/somewhere"
    file_name "Something.txt"
    line_count 1
    started_at "2015-06-15"
    ended_at "2015-06-15"
  end
end