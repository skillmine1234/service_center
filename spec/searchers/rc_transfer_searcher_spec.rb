require 'spec_helper'

describe RcTransferSearcher do
  context "searcher" do
    it "should return rc_transfer records" do 
      rc_transfer = Factory(:rc_transfer, :rc_transfer_code => '123')
      RcTransferSearcher.new({:rc_code => "123"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:rc_code => "1234"}).paginate.should == []

      rc_transfer = Factory(:rc_transfer, :debit_account_no => "1234")
      RcTransferSearcher.new({:debit_account_no => "1234"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:debit_account_no => "4321"}).paginate.should == []

      rc_transfer = Factory(:rc_transfer, :bene_account_no => "1234")
      RcTransferSearcher.new({:bene_account_no => "1234"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:bene_account_no => "4321"}).paginate.should == []

      rc_transfers = [Factory(:rc_transfer, :transfer_amount => '10000')]
      rc_transfers << Factory(:rc_transfer, :transfer_amount => '9000')
      rc_transfers << Factory(:rc_transfer, :transfer_amount => '8000')
      RcTransferSearcher.new({:from_amount => '8000', :to_amount => '10000'}).paginate.should == rc_transfers.reverse
      RcTransferSearcher.new({:from_amount => '10000', :to_amount => '12000'}).paginate.should == [rc_transfers[0]]

      rc_transfer = Factory(:rc_transfer, :status_code => 'NEW')
      RcTransferSearcher.new({:status => "NEW"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:status => "COMPLETED"}).paginate.should == []

      rc_transfer = Factory(:rc_transfer, :notify_status => 'NOTIFIED: OK')
      RcTransferSearcher.new({:notify_status => "NOTIFIED: OK"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:notify_status => "NEW"}).paginate.should == []

      rc_transfer = Factory(:rc_transfer, :mobile_no => "1234567890")
      RcTransferSearcher.new({:mobile_no => "1234567890"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:mobile_no => "4321335342"}).paginate.should == []

      rc_transfer = Factory(:rc_transfer, :pending_approval => "N")
      RcTransferSearcher.new({:pending_approval => "N"}).paginate.should == [rc_transfer]
      RcTransferSearcher.new({:pending_approval => "A"}).paginate.should == []
    end
  end
end