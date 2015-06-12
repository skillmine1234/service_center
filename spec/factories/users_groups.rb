# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_group do
    user_id {Factory(:user).id}
    group_id {Factory(:group).id}
  end
end
