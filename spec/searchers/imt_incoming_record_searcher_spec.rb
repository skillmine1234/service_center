require 'spec_helper'

describe ImtIncomingRecordSearcher do
  context 'searcher' do
    it 'should return imt_incoming_records' do
      a = Factory(:imt_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      ImtIncomingRecordSearcher.new({overrided_flag: "true",file_name: a.file_name, status: 'FAILED'}).paginate.should == [a]
      
      imt_incoming_record = Factory(:imt_incoming_record, :imt_ref_no => '2222')
      ImtIncomingRecordSearcher.new({imt_ref_no: '2222', file_name: imt_incoming_record.file_name, status: 'FAILED'}).paginate.should == [imt_incoming_record]
      ImtIncomingRecordSearcher.new({imt_ref_no: '2223', file_name: imt_incoming_record.file_name, status: 'FAILED'}).paginate.should == []

      imt_incoming_records = [Factory(:imt_incoming_record, :file_name => 'File01', :txn_issue_date => '2010-10-10')]
      imt_incoming_records << Factory(:imt_incoming_record, :file_name => 'File01', :txn_issue_date => '2014-12-12')
      ImtIncomingRecordSearcher.new({file_name: imt_incoming_records[0].file_name, from_issue_date: '2010-09-09', to_issue_date: '2010-10-20', status: 'FAILED'}).paginate.should == [imt_incoming_records[0]]
      ImtIncomingRecordSearcher.new({file_name: imt_incoming_records[0].file_name, from_issue_date: '2010-09-09', to_issue_date: '2015-10-20', status: 'FAILED'}).paginate.should == imt_incoming_records.reverse

      imt_incoming_records = [Factory(:imt_incoming_record, :file_name => 'File02', :txn_acquire_date => '2010-10-10')]
      imt_incoming_records << Factory(:imt_incoming_record, :file_name => 'File02', :txn_acquire_date => '2014-12-12')
      ImtIncomingRecordSearcher.new({file_name: imt_incoming_records[0].file_name, from_acquire_date: '2010-09-09', to_acquire_date: '2010-10-20', status: 'FAILED'}).paginate.should == [imt_incoming_records[0]]
      ImtIncomingRecordSearcher.new({file_name: imt_incoming_records[0].file_name, from_acquire_date: '2010-09-09', to_acquire_date: '2015-10-20', status: 'FAILED'}).paginate.should == imt_incoming_records.reverse

      imt_incoming_record = Factory(:imt_incoming_record, :transfer_amount => 100)
      ImtIncomingRecordSearcher.new({file_name: imt_incoming_record.file_name, from_amount: 50, to_amount: 200, status: 'FAILED'}).paginate.should == [imt_incoming_record]
      ImtIncomingRecordSearcher.new({file_name: imt_incoming_record.file_name, from_amount: 150, to_amount: 200, status: 'FAILED'}).paginate.should == []   
    end
  end
end
