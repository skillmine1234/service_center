# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ecol_rule do
    ifsc "ABCD0123456"
    cod_acct_no "1234567890"
    stl_gl_inward "1234567890"
    stl_gl_return "1234567890"
  end
end
