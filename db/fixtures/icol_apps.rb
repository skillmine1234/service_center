IcolApp.seed_once(:app_code) do |s|
  s.id = 10000
  s.app_code = 'HUDAAPP1'
  s.created_at = Date.current
  s.created_by = 'Q'
  s.expected_input = '[{"name":"name1","label":"customer name","dataType":"string"},{"name":"address","label":"customer address","dataType":"string"},{"name":"dob","label":"customer dob","dataType":"dateTime"}]'
  s.expected_output = '[{"name":"name2","label":"customer gender","dataType":"string","required":"true"},{"name":"place2","label":"customer address","dataType":"string","required":"true"},{"name":"place3","label":"customer address2","dataType":"string","required":"false","enum":["male","female"]}]'
end

IcolApp.seed_once(:app_code) do |s|
  s.id = 10001
  s.app_code = 'HUDAAPP2'
  s.created_at = Date.current
  s.created_by = 'Q'
  s.expected_input = '[{"name":"name1","label":"customer name","dataType":"string"},{"name":"address","label":"customer address","dataType":"string"},{"name":"dob","label":"customer dob","dataType":"dateTime"}]'
  s.expected_output = '[{"name":"name2","label":"customer gender","dataType":"string","required":"true"},{"name":"place2","label":"customer address","dataType":"string","required":"true"},{"name":"place3","label":"customer address2","dataType":"string","required":"false","enum":["male","female"]}]'
end