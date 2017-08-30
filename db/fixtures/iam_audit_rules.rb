IamAuditRule.seed_once(:created_by) do |s|
 s.interval_in_mins = '15'
 s.log_bad_org_uuid = 'N'
 s.enabled_at = Date.yesterday
 s.created_by = 'Q'
end