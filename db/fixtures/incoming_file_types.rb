ScService.seed(:code) do |s|
  s.code = 'AML'
  s.name = 'Anti Money Laundering'
end

ScService.seed(:code) do |s|
  s.code = 'ECOL'
  s.name = 'Ecollect'
end

ScService.seed(:code) do |s|
  s.code = 'IMTSERVICE'
  s.name = 'Instant Money Transfer'
end

ScService.seed(:code) do |s|
  s.code = 'SALARY'
  s.name = 'Salary Processing'
end



IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'AML').id
  s.code = 'SDN'
  s.name = 'Specially Designated Individuals'
  s.msg_domain = 'XMLNSC'
  s.msg_model = ''
  s.skip_first = 'N'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'AML').id
  s.code = 'OFAC'
  s.name = 'Office of Foreign Assets Control'
  s.msg_domain = 'XMLNSC'
  s.msg_model = ''
  s.skip_first = 'N'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'ECOL').id
  s.code = 'RMTRS'
  s.name = 'Remitters'
  s.msg_domain = 'DFDL'
  s.msg_model = 'eCollect'
  s.skip_first = 'Y'
  s.auto_upload = 'N'
  s.validate_all = 'N'
  s.build_response_file = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'ADDBENEFICIARY'
  s.name = 'Add Beneficiary'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:addBeneficiary'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'Y'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'DELETEBENEFICIARY'
  s.name = 'Delete Beneficiary'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:deleteBeneficiary'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'Y'  
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'INITIATETRANSFER'
  s.name = 'Initiate Transfer'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:initiateTransfer'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'Y'  
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'CANCELTRANSFER'
  s.name = 'Cancel Transfer'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:cancelTransfer'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'Y'  
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'TXNS'
  s.name = 'TXNS'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:empays_transaction'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = 'N' 
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'SALARY').id
  s.code = 'SALARY'
  s.name = 'SALARY'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:paySalary'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'Y' 
  s.db_unit_name = "pk_qg_su_file_validator.do"
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'PAYSALARY').id
  s.code = 'PAYSALARY'
  s.name = 'PAYSALARY'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:paySalary'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'Y' 
  s.db_unit_name = "pk_qg_su_file_validator.do"
end