require 'spec_helper'

describe Ic001IncomingRecordSearcher do
  context "searcher" do
    it "should return records for the params that is passed" do 
      a = Factory(:ic001_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      Ic001IncomingRecordSearcher.new({:overrided_flag => "true",file_name: a.file_name, status: 'FAILED'}).paginate.should == [a]
      
      ic001_incoming_record = Factory(:ic001_incoming_record, :anchor_account_id => '2222')
      Ic001IncomingRecordSearcher.new({:anchor_account_id => '2222',file_name: ic001_incoming_record.file_name, status: 'FAILED'}).paginate.should == [ic001_incoming_record]
      Ic001IncomingRecordSearcher.new({:anchor_account_id => '2223',file_name: ic001_incoming_record.file_name, status: 'FAILED'}).paginate.should == []

      ic001_incoming_record = Factory(:ic001_incoming_record, :invoice_no=> '2222')
      Ic001IncomingRecordSearcher.new({:invoice_no => '2222',file_name: ic001_incoming_record.file_name, status: 'FAILED'}).paginate.should == [ic001_incoming_record]
      Ic001IncomingRecordSearcher.new({:invoice_no => '2223',file_name: ic001_incoming_record.file_name, status: 'FAILED'}).paginate.should == []

      ic001_incoming_record = Factory(:ic001_incoming_record, :invoice_amount => 100)
      Ic001IncomingRecordSearcher.new({:from_amount => 50, :to_amount => 200,file_name: ic001_incoming_record.file_name, status: 'FAILED'}).paginate.should == [ic001_incoming_record]
      Ic001IncomingRecordSearcher.new({:from_amount => 150, :to_amount => 200,file_name: ic001_incoming_record.file_name, status: 'FAILED'}).paginate.should == []   
    end
  end
end