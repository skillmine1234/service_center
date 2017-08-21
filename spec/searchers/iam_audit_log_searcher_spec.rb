require 'spec_helper'
require 'flexmock/test_unit'

describe IamAuditLogSearcher do
  include HelperMethods
  before(:each) do
    mock_ldap
  end

  context 'searcher' do
    it 'should return iam_audit_logs records' do      
      iam_audit_log = Factory(:iam_audit_log, :org_uuid => 'org_123')
      IamAuditLogSearcher.new({:org_uuid => 'org_123'}).paginate.should == [iam_audit_log]
      IamAuditLogSearcher.new({:org_uuid => 'org_234'}).paginate.should == []
      
      iam_audit_log = Factory(:iam_audit_log, :cert_dn => 'A')
      IamAuditLogSearcher.new({:cert_dn => 'A'}).paginate.should == [iam_audit_log]
      IamAuditLogSearcher.new({:cert_dn => 'B'}).paginate.should == []

      iam_audit_log = Factory(:iam_audit_log, :source_ip => "10.0.0.1:3123")
      IamAuditLogSearcher.new({:source_ip => "10.0.0.1:3123"}).paginate.should == [iam_audit_log]
      IamAuditLogSearcher.new({:source_ip => "10.0.0.1:3124"}).paginate.should == []
    end
  end
end