EcolApp.seed(:app_code) do |s|
  s.app_code = 'UDFtest3'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest2/validate'
  s.notify_url = 'https://ditto.quantiguous.com/ecollect/qgtest2/notify'
  s.setting1_name  = 'name1'
  s.setting1_type  = 'text'
  s.setting1_value = 'qg'
  s.setting2_name  = 'name2'
  s.setting2_type  = 'number'
  s.setting2_value = 1
  s.udf1_name  = 'client_code'
  s.udf1_type  = 'text'
  s.udf2_name  = 'sort_code'
  s.udf2_type  = 'number'
  s.created_by = 'Q'
  s.approval_status = 'A'
end

EcolApp.seed(:app_code) do |s|
  s.app_code = 'UDFtest2'
  s.validate_url = 'https://ditto.quantiguous.com/ecollect/qgtest2/validate'
  s.notify_url = 'https://ditto.quantiguous.com/ecollect/qgtest2/notify'
  s.setting1_name  = 'name1'
  s.setting1_type  = 'text'
  s.setting1_value = 'qg'
  s.setting2_name  = 'name2'
  s.setting2_type  = 'number'
  s.setting2_value = 1
  s.udf1_name  = 'Text1'
  s.udf1_type  = 'text'
  s.udf2_name  = 'Text2'
  s.udf2_type  = 'number'
  s.created_by = 'Q'
  s.approval_status = 'A'
end