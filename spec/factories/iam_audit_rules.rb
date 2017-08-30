FactoryGirl.define do
  factory :iam_audit_rule do
    iam_organisation_id {Factory(:iam_organisation).id}
    enabled_at Time.zone.now
    interval_in_mins 10
    log_bad_org_uuid 'Y'
    lock_version 1
  end
end