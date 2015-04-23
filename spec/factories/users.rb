# Read about factories at http://github.com/thoughtbot/factory_girl
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) {|n| "user#{n}@example.com" }
    f.sequence(:username) {|n| "user#{n}@example.com" }
    f.password 'testing123'
    f.created_at 2.day.ago.to_s(:db)
    f.updated_at 1.day.ago.to_s(:db)
    f.inactive 0
  end
end
