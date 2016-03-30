FactoryGirl.define do
  factory :su_audit_step do
    su_auditable_id 1
    su_auditable_type "SuIncomingRecord"
    step_no 1
    attempt_no 1
    status_code "NEW"
    step_name "NEW"
  end
end