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

  context "find_rc_transfer_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:rc_transfer, :rc_transfer_code => '123')
      find_rc_transfers({:rc_code => "123"},RcTransfer).should == [a]
      find_rc_transfers({:rc_code => "1234"},RcTransfer).should == []
      a = Factory(:rc_transfer, :batch_no => 1)
      find_rc_transfers({:batch_no => 1},RcTransfer).should == [a]
      find_rc_transfers({:batch_no => 2},RcTransfer).should == []
      a = Factory(:rc_transfer, :debit_account_no => "1234")
      find_rc_transfers({:debit_account_no => "1234"},RcTransfer).should == [a]
      find_rc_transfers({:debit_account_no => "4321"},RcTransfer).should == []
      a = Factory(:rc_transfer, :started_at => Time.zone.now)
      find_rc_transfers({:from_date => Date.today.advance(:days => -1).to_s, :to_date => Date.today.advance(:days => 2).to_s},RcTransfer).should == [a]
      find_rc_transfers({:from_date => Date.today.advance(:days => -5).to_s, :to_date => Date.today.advance(:days => -4).to_s},RcTransfer).should == []
    end
  end
end
