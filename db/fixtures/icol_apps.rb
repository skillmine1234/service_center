IcolApp.seed_once(:app_code) do |s|
  s.id = 10000
  s.app_code = 'HUDABP'
  s.created_at = Time.zone.now
  s.created_by = 'Q'
  s.expected_input = '[{"name":"field1","label":"Site Code","dataType":"string"},{"name":"field2","label":"Consumer No","dataType":"string"}]'
end

IcolApp.seed_once(:app_code) do |s|
  s.id = 10001
  s.app_code = 'HUDAVP'
  s.created_at = Time.zone.now
  s.created_by = 'Q'
  s.expected_input = '[{"name":"field1","label":"Voucher No","dataType":"string"}]'
end
