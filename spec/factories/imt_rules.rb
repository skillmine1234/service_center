# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :imt_rule do
    stl_gl_account "1234567890"
    chargeback_gl_account "1234567891"
    approval_status 'U'
    last_action 'C'
  end
end
