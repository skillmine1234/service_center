# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_mm_cd_incoming_file do
    file_name {Factory(:incoming_file).file_name}
  end
end