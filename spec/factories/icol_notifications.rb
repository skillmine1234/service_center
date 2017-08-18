# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :icol_notification do
    app_code 'APP12'
    sequence(:customer_code) {|n| "%03i" % "#{n}"}
    status_code 'Success'
  end
end