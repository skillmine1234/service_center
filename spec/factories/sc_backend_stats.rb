# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sc_backend_stat do
    # sequence(:code) {|n| "9" + "%03i" % "#{n}" }
    code {Factory(:sc_backend).code}
    new_status 'U'
    remarks 'MyString'
    created_by 1
  end
end