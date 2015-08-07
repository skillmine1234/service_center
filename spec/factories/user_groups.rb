
FactoryGirl.define do
  factory :user_group do
    user_id {Factory(:user).id}
    group_id {Factory(:group).id}
    approval_status 'A'
    disabled false
  end
end
