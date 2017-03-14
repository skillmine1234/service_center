# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pc_app do
    program_code {Factory(:pc_program, :approval_status => 'A').code}
    sequence(:app_id) {|n| "90" + "%03i" % "#{n}" }
    is_enabled "N"
    approval_status "U"
    identity_user_id { Factory(:iam_cust_user, approval_status: 'A').username }
  end
end
