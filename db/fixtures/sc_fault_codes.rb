ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'ns:E402'
 s.fault_reason = 'Insufficient Balance in debit account, payment required'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'Fund the debit account and retry'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E9072'
 s.fault_reason = 'Destination Bank and Branch could not be resolved'
 s.fault_kind = 'B'
 s.occurs_when = 'N'
 s.remedial_action = 'Retry with correct beneficiary IFSC Code'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E8036'
 s.fault_reason = 'NEFT - Both Customer Mobile and Email is not valid'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'Issue with Remitter Account setup Contact Support'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E8087'
 s.fault_reason = 'To Account Number is Invalid'
 s.fault_kind = 'B'
 s.occurs_when = 'To Account Number is Invalid'
 s.remedial_action = 'Retry with correct Beneficiary/customer Account'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E18'
 s.fault_reason = 'Hold Funds Present - Refer to Drawer ( Account would Overdraw )'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'Account is in hold status. Contact Support'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E6833'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:EE0010'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E9006'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E2118'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E9026'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11000'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11001'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11004'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11005'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11011'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11012'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11013'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11014'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11015'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E11016'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'flex:E6833'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E70'
 s.fault_reason = 'Outward Transaction Rejected'
 s.fault_kind = 'B'
 s.occurs_when = 'Transaction is in error due to issue with the transaction details.'
 s.remedial_action = 'Give back money'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E18'
 s.fault_reason = 'Rejected by SFMS'
 s.fault_kind = 'B'
 s.occurs_when = 'Transaction is not accepted by the payment body'
 s.remedial_action = 'Give back money'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E99'
 s.fault_reason = 'Manually Marked in Error'
 s.fault_kind = 'B'
 s.occurs_when = 'Transaction is in error due to issue with the transaction details'
 s.remedial_action = 'Give back money'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E28'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E30'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E93'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E62'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'Transaction accepted by RBI but beneficiary bank rejected it'
 s.remedial_action = 'Give back money'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:E19'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:EFRJ'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:EPIR'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:ERBA'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:ERBH'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:ERBR'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:EREJ'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:ESSN'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:ETRJ'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:EREV'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'SFMS:EREV'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'ns:E1015'
 s.fault_reason = 'NULL'
 s.fault_kind = 'B'
 s.occurs_when = 'NULL'
 s.remedial_action = 'NULL'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'ns:E504'
 s.fault_reason = 'Gateway Timeout'
 s.fault_kind = 'B'
 s.occurs_when = 'An upstream service times out'
 s.remedial_action = 'Retry Request After 15 checking the status'
end

ScFaultCode.seed_once(:fault_code) do |s|
 s.fault_code = 'ns:E502'
 s.fault_reason = 'Bad Gateway'
 s.fault_kind = 'B'
 s.occurs_when = 'An upstream service returned an unexpected error'
 s.remedial_action = 'Contact Support'
end