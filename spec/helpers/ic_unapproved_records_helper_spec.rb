require 'spec_helper'

describe IcUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      ic_unapproved_record = Factory(:ic_unapproved_record, :ic_approvable_type => 'IcCustomer')
      filter_records(IcUnapprovedRecord,{}).should eq([{:record_type=>"IcCustomer", :record_count=>1}, {:record_type=>"IcSupplier", :record_count=>0}, {:record_type=>"IncomingFile", :record_count=>0}])
    end
  end
end

