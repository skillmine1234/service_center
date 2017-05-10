FactoryGirl.define do
  factory :ic001_incoming_file do
    file_name {Factory(:incoming_file).file_name}
  end
end