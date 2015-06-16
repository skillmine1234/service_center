require 'spec_helper'

describe IncomingFileHelper do
  
  context "find_incoming_files" do 
    it "should return incoming files" do
      sc_name = Factory(:sc_service, :code => '1234')
      incoming_file = Factory(:incoming_file, :service_name => '1234')
      find_incoming_files({:service_name => "1234"}).should == [incoming_file]
      find_incoming_files({:service_name => "CUST01"}).should == [] 
      
      file_type = Factory(:incoming_file_type, :code => '1234')
      incoming_file = Factory(:incoming_file, :file_type => '1234')
      find_incoming_files({:file_type => "1234"}).should == [incoming_file]
      find_incoming_files({:file_type=> "CUST01"}).should == [] 

      incoming_file = Factory(:incoming_file, :file_name => 'Process Type')
      find_incoming_files({:file_name => "process"}).should == [incoming_file]
      find_incoming_files({:file_name => "CUST01"}).should == [] 
    end
  end
end
