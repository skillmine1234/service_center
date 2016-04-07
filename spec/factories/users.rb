# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do 
    sequence(:email) {|n| "user#{n}@example.com" }
    sequence(:username) {|n| "user#{n}@example.com" }
    password 'testing123'
    created_at 2.day.ago.to_s(:db)
    updated_at 1.day.ago.to_s(:db)
    inactive 0
    after_create do |user| 
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'inward-remittance').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'e-collect').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'bill-management').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'prepaid-card').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'prepaid-card2').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'flex-proxy').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'imt').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'funds-transfer').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'salary-upload').id)
      Factory(:user_group, :user_id => user.id, :group_id => Factory(:group, :name => 'instant-credit').id)
    end
  end
end
