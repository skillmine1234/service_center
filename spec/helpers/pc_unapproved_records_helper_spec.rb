require 'spec_helper'

describe PcUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      pc_unapproved_record = Factory(:pc_unapproved_record, :pc_approvable_type => 'PcApp')
      filter_records(PcUnapprovedRecord).should eq([{:record_type=>"PcApp", :record_count=>1}, {:record_type=>"PcFeeRule", :record_count=>0}])
    end
  end
end
