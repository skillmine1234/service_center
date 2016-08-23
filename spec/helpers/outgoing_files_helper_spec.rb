require 'spec_helper'

describe OutgoingFilesHelper do
  
  context "find_outgoing_files" do 
    it "should return outgoing files" do
      outgoing_file = Factory(:outgoing_file, :file_type => '1234')
      find_outgoing_files({:file_type => "1234"}).should == [outgoing_file]
      find_outgoing_files({:file_type=> "CUST01"}).should == [] 

      outgoing_file = Factory(:outgoing_file, :file_name => 'Process Type')
      find_outgoing_files({:file_name => "process"}).should == [outgoing_file]
      find_outgoing_files({:file_name => "CUST01"}).should == [] 
    end
  end
end
