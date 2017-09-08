require 'spec_helper'

describe SspAuditStepSearcher do
  context "searcher" do
    it "should return ssp_audit_step records" do
      ssp_audit_step = Factory(:ssp_audit_step, :app_code => "QW12345")
      SspAuditStepSearcher.new({:app_code => "QW12345"}).paginate.should == [ssp_audit_step]
      SspAuditStepSearcher.new({:app_code => "QAQWSWQ"}).paginate.should == []
      
      ssp_audit_step = Factory(:ssp_audit_step, :customer_code => "Cust12345")
      SspAuditStepSearcher.new({:customer_code => "Cust12345"}).paginate.should == [ssp_audit_step]
      SspAuditStepSearcher.new({:customer_code => "QAQWSWQ"}).paginate.should == []
      
      ssp_audit_step = Factory(:ssp_audit_step, :status_code => "NEW")
      SspAuditStepSearcher.new({:status_code => "NEW"}).paginate.should == [ssp_audit_step]
      SspAuditStepSearcher.new({:status_code => "FAILED"}).paginate.should == []
      
      ssp_audit_step = Factory(:ssp_audit_step, :step_name => "Step12345")
      SspAuditStepSearcher.new({:step_name => "Step12345"}).paginate.should == [ssp_audit_step]
      SspAuditStepSearcher.new({:step_name => "QAQWSWsdQ"}).paginate.should == []

      ssp_audit_steps = [Factory(:ssp_audit_step, req_timestamp: '2015-10-10')]
      ssp_audit_steps << Factory(:ssp_audit_step, req_timestamp: '2015-11-10')
      ssp_audit_steps << Factory(:ssp_audit_step, req_timestamp: '2016-02-01')
      SspAuditStepSearcher.new({from_request_timestamp: '2015-10-10', to_request_timestamp: '2015-12-10'}).paginate.should == [ssp_audit_steps[1], ssp_audit_steps[0]]
      SspAuditStepSearcher.new({from_request_timestamp: '2016-01-01', to_request_timestamp: '2016-12-12'}).paginate.should == [ssp_audit_steps[2]]
      SspAuditStepSearcher.new({from_request_timestamp: '2018-01-01', to_request_timestamp: '2018-12-12'}).paginate.should == []
      
      ssp_audit_steps = [Factory(:ssp_audit_step, rep_timestamp: '2015-10-10')]
      ssp_audit_steps << Factory(:ssp_audit_step, rep_timestamp: '2015-11-10')
      ssp_audit_steps << Factory(:ssp_audit_step, rep_timestamp: '2016-02-01')
      SspAuditStepSearcher.new({from_reply_timestamp: '2015-10-10', to_reply_timestamp: '2015-12-10'}).paginate.should == [ssp_audit_steps[1], ssp_audit_steps[0]]
      SspAuditStepSearcher.new({from_reply_timestamp: '2016-01-01', to_reply_timestamp: '2016-12-12'}).paginate.should == [ssp_audit_steps[2]]
      SspAuditStepSearcher.new({from_reply_timestamp: '2018-01-01', to_reply_timestamp: '2018-12-12'}).paginate.should == []
    end
  end
end