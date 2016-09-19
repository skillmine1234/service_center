# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_program do
    sequence(:code) {|n| "%04i" % "#{n}"}
    is_enabled "Y"
    created_by "MyString"
    updated_by "MyString"
    lock_version 0
    approval_status "U"
    last_action "MyString"
  end
end
