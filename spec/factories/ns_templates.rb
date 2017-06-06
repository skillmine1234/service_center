# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ns_template do
    sc_event_id {Factory(:sc_event).id}
    sms_template 'This is a SMS template'
  end
end