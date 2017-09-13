IcolApp.seed_once(:app_code) do |s|
  s.id = 10000
  s.app_code = 'HUDABP'
  s.created_at = Time.zone.now
  s.created_by = 'Q'
  s.expected_input = '[{"name":"Site_Code","label":"Site Code","dataType":"string"},{"name":"Consumer_No","label":"Consumer No","dataType":"string"}]'
end

IcolApp.seed_once(:app_code) do |s|
  s.id = 10001
  s.app_code = 'HUDAVP'
  s.created_at = Time.zone.now
  s.created_by = 'Q'
  s.expected_input = '[{"name":"Voucher_No","label":"Voucher No","dataType":"string"}]'
end
