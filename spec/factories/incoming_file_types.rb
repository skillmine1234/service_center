FactoryGirl.define do
  factory :incoming_file_type do
    sc_service_id {Factory(:sc_service).id}
    sequence(:code) {|n| "#{n}" }
    sequence(:name) {|n| "#{n}" }
  end
end
