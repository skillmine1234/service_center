require 'spec_helper'

describe RcTransfersHelper do
  context "find_logs" do 
    it "should return audit_steps results" do 
      rc_transfer = Factory(:rc_transfer)
      a = Factory(:rc_audit_step, :rc_auditable => rc_transfer)
      params = {:id => rc_transfer.id, :step_name => "ALL"}
      find_logs(params,rc_transfer).should == [a]
    end
  end
end
