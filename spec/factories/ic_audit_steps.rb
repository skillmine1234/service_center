FactoryGirl.define do
  factory :ic_audit_step do
    ic_auditable_id 1
    ic_auditable_type "IcIncomingRecord"
    step_no 1
    attempt_no 1
    status_code "NEW"
    step_name "NEW"
  end
end