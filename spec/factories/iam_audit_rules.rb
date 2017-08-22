FactoryGirl.define do
  factory :iam_audit_rule do
    org_uuid 'UUID'
    cert_dn '123123'
    source_ip '10.0.20.230'
    interval_in_mins 10
    lock_version 1
  end
end