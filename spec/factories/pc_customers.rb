# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_customer do
    app_id {Factory(:pc_app, :approval_status => 'A').app_id}
  end
end
