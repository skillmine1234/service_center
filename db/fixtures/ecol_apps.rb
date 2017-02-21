EcolApp.seed_once(:app_code) do |s|
  s.app_code = 'QGTEST1'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest1/validate'
  s.notify_url = 'https://ditto.quantiguous.com/ecollect/qgtest1/notify'
  s.created_by = 'Q'
  s.approval_status = 'A'
end

EcolApp.seed_once(:app_code) do |s|
  s.app_code = 'QGTEST2'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest2/validate'
  s.notify_url = 'https://ditto.quantiguous.com/ecollect/qgtest2/notify'
  s.setting1_name  = 'name1'
  s.setting1_type  = 'text'
  s.setting1_value = 'qg'
  s.setting2_name  = 'name2'
  s.setting2_type  = 'number'
  s.setting2_value = 1
  s.setting3_name  = 'name3'
  s.setting3_type  = 'date'
  s.setting3_value = '2017-01-01'
  s.setting4_name  = 'name4'
  s.setting4_type  = 'text'
  s.setting4_value = 'value4'
  s.setting5_name  = 'name5'
  s.setting5_type  = 'date'
  s.setting5_value = '2015-01-10'
  s.created_by = 'Q'
  s.approval_status = 'A'
end

EcolApp.seed_once(:app_code) do |s|
  s.app_code = 'QGTEST3'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest3/validate'
  s.notify_url = 'https://ditto.quantiguous.com/ecollect/qgtest3/notify'
  s.created_by = 'Q'
  s.approval_status = 'A'
end

EcolApp.seed_once(:app_code) do |s|
  s.app_code = 'QGTEST4'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest4/validate'
  s.notify_url = 'https://ditto.quantiguous.com/ecollect/qgtest4/notify'
  s.created_by = 'Q'
  s.approval_status = 'A'
end

EcolApp.seed_once(:app_code) do |s|
  s.app_code = 'QGTEST5'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest5/validate'
  s.created_by = 'Q'
  s.approval_status = 'A'
end

EcolApp.seed_once(:app_code) do |s|
  s.app_code = 'QGTEST6'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest6/validate'
  s.created_by = 'Q'
  s.approval_status = 'A'
end
