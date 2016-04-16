require 'spec_helper'

describe SuUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      su_unapproved_record = Factory(:su_unapproved_record, :su_approvable_type => 'SuCustomer')
      filter_records(SuUnapprovedRecord,{}).should eq([{:record_type=>"SuCustomer", :record_count=>1}, {:record_type=>"IncomingFile", :record_count=>0}])
    end
  end
end

