FtPurposeCode.seed(:code) do |s|
  s.code = 'GST'
  s.is_enabled = 'Y'
  s.is_frozen = 'Y'
  s.is_enabled = 'Y'
  s.description = 'GST'
  s.allow_only_registered_bene = 'N'
  s.allowed_transfer_types = ['NEFT', 'RTGS']
  s.setting1_name = 'beneficiary_name'
  s.setting1_type = 'text'
  s.setting2_name = 'beneficiary_ifsc'
  s.setting2_type = 'text'
  s.approval_status = 'A'
  s.created_by = 'Q'
end