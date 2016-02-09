ScService.seed(:code) do |s|
  s.code = 'IMTSERVICE'
  s.name = 'Instant Money Transfer'
end

OutgoingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'initiated_transfers'
  s.name = 'initiated_transfers'
  s.db_unit_name = 'pk_qg_imt_extract.initiated_transfers'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file/extracts}:initiated_transfers'
  s.row_name = 'initiated_transfer'
  s.file_name = 'initiated_transfers'
  s.run_at_hour = 10
  s.run_at_day = 'D'
  s.last_run_at = Time.now
  s.batch_size = 50
  s.write_header = "Y"
end

OutgoingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'expired_transfers'
  s.name = 'expired_transfers'
  s.db_unit_name = 'pk_qg_imt_extract.expired_transfers'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file/extracts}:expired_transfers'
  s.row_name = 'expired_transfer'
  s.file_name = 'expired_transfers'
  s.run_at_hour = 10
  s.run_at_day = 'D'
  s.last_run_at = Time.now
  s.batch_size = 50  
  s.write_header = "Y"
end

OutgoingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'completed_transfers'
  s.name = 'completed_transfers'
  s.db_unit_name = 'pk_qg_imt_extract.completed_transfers'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file/extracts}:completed_transfers'
  s.row_name = 'completed_transfer'
  s.file_name = 'completed_transfers'
  s.run_at_hour = 10
  s.run_at_day = 'D'
  s.last_run_at = Time.now  
  s.batch_size = 50  
  s.write_header = "Y"  
end

OutgoingFileType.seed(:sc_service_id, :code) do |s|
  s.sc_service_id = ScService.find_by(code: 'IMTSERVICE').id
  s.code = 'transfer_charges'
  s.name = 'transfer_charges'
  s.db_unit_name = 'pk_qg_imt_extract.transfer_charge'
  s.msg_domain = 'DFDL'
  s.msg_model = '{http://www.quantiguous.com/services/file/extracts}:transfer_charges'
  s.row_name = 'transfer_charge'
  s.file_name = 'transfer_charges'
  s.run_at_hour = 10
  s.run_at_day = '5'
  s.last_run_at = Time.now
  s.batch_size = 50  
  s.write_header = "N" 
  s.email_to = "hello@quantiguous.com"
  s.email_cc = "neha.upadhyay@quantiguous.com"
  s.email_subject = "IMT TRANSACTION PROCESSING" 
end