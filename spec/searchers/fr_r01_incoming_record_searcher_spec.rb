require 'spec_helper'

describe FrR01IncomingRecordSearcher do
  context 'searcher' do
    it 'should return fr_r01 incoming records' do
      a = Factory(:fr_r01_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      FrR01IncomingRecordSearcher.new({overrided_flag: "true",file_name: a.file_name, status: 'FAILED'}).paginate.should == [a]
      
      fr_r01_incoming_record = Factory(:fr_r01_incoming_record, account_no: '1111222233')
      FrR01IncomingRecordSearcher.new({account_no: '1111222233',file_name: fr_r01_incoming_record.file_name, status: 'FAILED'}).paginate.should == [fr_r01_incoming_record]
      FrR01IncomingRecordSearcher.new({account_no: '2223',file_name: fr_r01_incoming_record.file_name, status: 'FAILED'}).paginate.should == []
      
      fr_r01_incoming_record = Factory(:fr_r01_incoming_record, customer_name: 'MyString123')
      FrR01IncomingRecordSearcher.new({customer_name: 'MyString123',file_name: fr_r01_incoming_record.file_name, status: 'FAILED'}).paginate.should == [fr_r01_incoming_record]
      FrR01IncomingRecordSearcher.new({customer_name: '123MyString',file_name: fr_r01_incoming_record.file_name, status: 'FAILED'}).paginate.should == []
    end
  end
end
