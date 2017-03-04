require 'spec_helper'

describe Cnb2IncomingRecordSearcher do
  context 'searcher' do
    it 'should return cnb2 incoming records' do
      a = Factory(:cnb2_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      Cnb2IncomingRecordSearcher.new({overrided_flag: "true",file_name: a.file_name, status: 'FAILED'}).paginate.should == [a]
      
      cnb2_incoming_record = Factory(:cnb2_incoming_record, :pay_comp_code=> '2222')
      Cnb2IncomingRecordSearcher.new({pay_comp_code: '2222',file_name: cnb2_incoming_record.file_name, status: 'FAILED'}).paginate.should == [cnb2_incoming_record]
      Cnb2IncomingRecordSearcher.new({pay_comp_code: '2223',file_name: cnb2_incoming_record.file_name, status: 'FAILED'}).paginate.should == []
      
      cnb2_incoming_record = Factory(:cnb2_incoming_record, :vendor_code=> '2222')
      Cnb2IncomingRecordSearcher.new({vendor_code: '2222',file_name: cnb2_incoming_record.file_name, status: 'FAILED'}).paginate.should == [cnb2_incoming_record]
      Cnb2IncomingRecordSearcher.new({vendor_code: '2223',file_name: cnb2_incoming_record.file_name, status: 'FAILED'}).paginate.should == []

      cnb2_incoming_record = Factory(:cnb2_incoming_record, :bene_account_no => '1234567')
      Cnb2IncomingRecordSearcher.new({bene_account_no: '1234567',file_name: cnb2_incoming_record.file_name, status: 'FAILED'}).paginate.should == [cnb2_incoming_record]
      Cnb2IncomingRecordSearcher.new({bene_account_no: '12345',file_name: cnb2_incoming_record.file_name, status: 'FAILED'}).paginate.should == []
    end
  end
end
