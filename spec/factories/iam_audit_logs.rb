FactoryGirl.define do
  factory :iam_audit_log do
    org_uuid "MyString"
    cert_dn "MyString"
    source_ip "10.0.0.1:3000"
    req_bitstream "request ---------sddasdasdasd"
    rep_bitstream "reply - ---sddasdasdasd"
    req_timestamp "2017-08-21 08:56:51"
    rep_timestamp "2017-08-22 08:56:51"
    fault_code "sddsdsd"
    fault_reason "sdasdad"
  end
end