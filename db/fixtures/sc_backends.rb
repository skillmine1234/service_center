ScBackend.seed(:code) do |s|
  s.code = 'FCR'
  s.do_auto_shutdown = 'Y'
  s.do_auto_start = 'N'

  s.window_in_mins = 5
  
  s.max_consecutive_failures = 3
  s.min_consecutive_success = 3
  
  s.max_window_failures = 5
  s.min_window_success = 6

  s.created_by = 'Q'
  s.created_at = Time.zone.now
  s.approval_status = 'A'
end

ScBackendStatus.seed(:code) do |s|
  s.code = 'FCR'
  s.status = 'U'
end

ScBackendStat.seed(:code) do |s|
  s.code = 'FCR'
  s.consecutive_failure_cnt = 0
  s.consecutive_success_cnt = 0
  s.window_started_at = Time.zone.now
  s.window_ends_at = Time.zone.now
  s.window_failure_cnt = 0
  s.window_success_cnt = 0
  s.auditable_type = 'seed'
  s.auditable_id = 0
end

ScBackend.seed(:code) do |s|
  s.code = 'ATOM'
  s.do_auto_shutdown = 'Y'
  s.do_auto_start = 'N'

  s.window_in_mins = 5
  s.max_consecutive_failures = 3
  s.min_consecutive_success = 3

  s.max_window_failures = 5
  s.min_window_success = 6
  

  s.created_by = 'Q'
  s.created_at = Time.zone.now
  s.approval_status = 'A'
end

ScBackendStatus.seed(:code) do |s|
  s.code = 'ATOM'
  s.status = 'U'  
end

ScBackendStat.seed(:code) do |s|
  s.code = 'ATOM'
  s.consecutive_failure_cnt = 0
  s.consecutive_success_cnt = 0
  s.window_started_at = Time.zone.now
  s.window_ends_at = Time.zone.now
  s.window_failure_cnt = 0
  s.window_success_cnt = 0
  s.auditable_type = 'seed'
  s.auditable_id = 0
end
