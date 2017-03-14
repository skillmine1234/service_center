module HelperMethods
  def create_attachment(ticket)
    file = File.new(Rails.root + 'spec/fixtures/rails.png')
    Factory(:attachment, :note => 'attachment note',:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)), :attachable => ticket)
  end
  
  def mock_ldap
    conn = Net::LDAP.new
    ldap_obj = flexmock(LDAP, ldap: conn)
    get_optn_result = flexmock("result", code: 0)
    mock = flexmock(ldap_obj.ldap, add: true, modify: true, get_operation_result: get_optn_result)
  end
end
