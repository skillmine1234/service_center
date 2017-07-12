FactoryGirl.define do
  factory :iam_organisation do
    name "MyString"
    sequence(:org_uuid) {|n| "UUID0" + "%06i" % "#{n}" }
    on_vpn "N"
    cert_dn "MyString"
    is_enabled "Y"
    approval_status "U"
    last_action "C"
    lock_version 1
    approved_version 1
    email_id 'abc@foobar.com'
    source_ips "123.12.12.1"
  end
end