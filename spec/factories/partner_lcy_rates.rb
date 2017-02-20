# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :partner_lcy_rate do
    partner_code {Factory(:partner, :approval_status => 'A').code}
    is_enabled 'Y'
    rate 1
    created_by "MyString"
    updated_by "MyString"
  end
end
