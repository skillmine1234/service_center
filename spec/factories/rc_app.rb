# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rc_app do
    sequence(:app_id) {|n| "%03i" % "#{n}"}
    udf1_name 'udf1'
    udf1_type 'number'
    url 'http://localhost'
  end
end