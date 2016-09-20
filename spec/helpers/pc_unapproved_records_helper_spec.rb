require 'spec_helper'

describe PcUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      pc_unapproved_record1 = Factory(:pc_unapproved_record, :pc_approvable_type => 'PcApp')
      pc_unapproved_record2 = Factory(:pc_unapproved_record, :pc_approvable_type => 'PcProgram')
      filter_records(PcUnapprovedRecord).should eq([{:record_type=>"PcApp", :record_count=>1}, {:record_type=>"PcFeeRule", :record_count=>0}, {:record_type=>"PcProgram", :record_count=>1}, {:record_type=>"PcProduct", :record_count=>0}, {:record_type=>"IncomingFile", :record_count=>0}])
    end
  end
end
