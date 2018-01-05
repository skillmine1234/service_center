ScService.seed(:code) do |s|
  s.code = 'AML'
  s.name = 'Anti Money Laundering'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'ECOL'
  s.name = 'Ecollect'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'SALARY'
  s.name = 'Salary Processing'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'INSTANTCREDIT'
  s.name = 'Instant Credit'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'FUNDSTRANSFER'
  s.name = 'Funds Transfer'
  s.url = 'https://uatsky.yesbank.in/app/uat/fundsTransferByCustomerService2'
  s.use_proxy = 'N'

  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'PPC'
  s.name = 'Prepaid Cards'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'CNB'
  s.name = 'Corporate Net Banking'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'RR'
  s.name = 'reconciled returns'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'FR'
  s.name = 'File Reports'
  s.approval_status = 'A'
  s.created_by = 'Q'
end

ScService.seed(:code) do |s|
  s.code = 'CP'
  s.name = 'Cinepolis File Upload'
  s.approval_status = 'A'
  s.created_by = 'Q'
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
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
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
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
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
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
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
  s.db_unit_name = "pk_qg_su_file_manager"
  s.records_table = 'su_incoming_records'
  s.can_override = 'Y'
  s.can_skip = 'Y'
  s.can_retry = 'Y'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
  s.complete_with_failed_records = 'N'
  s.apprv_before_process_records = 'Y'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'INSTANTCREDIT').id
  s.code = 'PAYNOW'
  s.name = 'REPAYMENT'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:repayCredit'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'Y' 
  s.db_unit_name = "pk_qg_ic_file_manager"
  s.records_table = 'ic_incoming_records'
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'Y'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
end
  
IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'FUNDSTRANSFER').id
  s.code = 'FUNDSTRANSFER'
  s.name = 'FUNDSTRANSFER'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:fundsTransfer'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'Y' 
  s.db_unit_name = "pk_qg_ft_file_manager"
  s.records_table = 'ft_incoming_records'  
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'Y'
  s.build_nack_file = 'Y'
  s.skip_last = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'PPC').id
  s.code = 'MMCD'
  s.name = 'MMCD'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:mmCrDr'
  s.skip_first = 'Y'
  s.auto_upload = 'N'
  s.validate_all = 'Y'
  s.build_response_file = 'Y' 
  s.db_unit_name = "pk_qg_pc_mm_cd_file_manager"
  s.records_table = 'pc_mm_cd_incoming_records'  
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'CNB').id
  s.code = 'CNB'
  s.name = 'CNB'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:ePAY'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'N'
  s.db_unit_name = "pk_qg_cn_file_manager"
  s.records_table = 'cn_incoming_records'
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'Y'
  s.skip_last = 'Y'
  s.complete_with_failed_records = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'RR').id
  s.code = 'RR'
  s.name = 'RR'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:reconciledReturns'
  s.skip_first = 'Y'
  s.auto_upload = 'N'
  s.validate_all = 'Y'
  s.build_response_file = 'N'
  s.db_unit_name = "pk_qg_rr_file_manager"
  s.records_table = 'rr_incoming_records'
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'CNB').id
  s.code = 'CNB2'
  s.name = 'Reliance File Upload'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:reliance'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'N'
  s.db_unit_name = "pk_qg_cnb2_file_manager"
  s.records_table = 'cnb2_incoming_records'
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'Y'
  s.skip_last = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'INSTANTCREDIT').id
  s.code = 'IC_001'
  s.name = 'Puratech FileUpload'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:ic_001'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'N'
  s.db_unit_name = "pk_qg_ic_001_file_manager"
  s.records_table = 'ic001_incoming_records'
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'N'
  s.skip_last = 'N'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'FR').id
  s.code = 'R01'
  s.name = 'Balance Enquiry'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file}:r01'
  s.skip_first = 'Y'
  s.auto_upload = 'Y'
  s.validate_all = 'Y'
  s.build_response_file = 'Y'
  s.db_unit_name = "pk_qg_fr_r01_file_manager"
  s.records_table = 'fr_r01_incoming_records'
  s.can_override = 'N'
  s.can_skip = 'Y'
  s.can_retry = 'N'
  s.build_nack_file = 'Y'
  s.skip_last = 'N'
  s.complete_with_failed_records = 'Y'
end

IncomingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'CP').id
  s.code = 'CP'
  s.name = 'Cinepolis File Upload'
  s.msg_domain = 'XMLNSC'
  s.msg_model = ''
  s.skip_first = 'N'
  s.auto_upload = 'Y'
  s.validate_all = 'N'
  s.build_response_file = ''
  s.db_unit_name = ""
  s.records_table = ''
  s.can_override = 'N'
  s.can_skip = 'N'
  s.can_retry = 'N'
  s.build_nack_file = 'Y'
  s.skip_last = 'N'
  s.max_file_size = '10'
  s.finish_each_file = 'N'
  s.is_file_mapper = 'Y'
end
