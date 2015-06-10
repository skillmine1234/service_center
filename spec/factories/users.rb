# Read about factories at http://github.com/thoughtbot/factory_girl
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do 
    sequence(:email) {|n| "user#{n}@example.com" }
    sequence(:username) {|n| "user#{n}@example.com" }
    password 'testing123'
    created_at 2.day.ago.to_s(:db)
    updated_at 1.day.ago.to_s(:db)
    inactive 0
    role_id {Factory(:role, :name => 'editor').id}
    group_id {Factory(:group, :name => 'inward-remittance').id}
  end
end
