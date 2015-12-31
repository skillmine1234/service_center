FactoryGirl.define do
  factory :fp_auth_rule do
    sequence(:username) {|n| "9" + "%03i" % "#{n}" }
    operation_name ["MyString"]
    is_enabled "N"
    approval_status "U"
    any_source_ip "Y"
    source_ips ""
  end
end