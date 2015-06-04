require 'spec_helper'

describe InwardRemittanceHelper do
  
  context 'find_inward_remittance' do
    it 'should return inward remittances' do
      inward_remittances = Factory(:inward_remittance,:status_code => 'IN_PROCESS')
      find_inward_remittances({:status => 'IN_PROCESS'}).should == [inward_remittances]
      find_inward_remittances({:status => 'COMPLETED'}).should == []
      
      inward_remittance = Factory(:inward_remittance,:req_no => 'R1234')
      find_inward_remittances({:request_no => 'R1234'}).should == [inward_remittance]
      find_inward_remittances({:request_no => 'r1234'}).should == [inward_remittance]
      find_inward_remittances({:request_no => 'r12'}).should == [inward_remittance]
      find_inward_remittances({:request_no => 'R12'}).should == [inward_remittance]
      find_inward_remittances({:request_no => '4321R'}).should == []
      
      inward_remittance = Factory(:inward_remittance,:partner_code => 'PARTNER1')
      find_inward_remittances({:partner_code => 'PARTNER1'}).should == [inward_remittance]
      find_inward_remittances({:partner_code => 'PART'}).should == [inward_remittance]
      find_inward_remittances({:partner_code => 'part'}).should == [inward_remittance]
      find_inward_remittances({:partner_code => 'PARTNER2'}).should == []
      
      inward_remittance = Factory(:inward_remittance,:req_transfer_type => 'IMPS')
      find_inward_remittances({:req_transfer_type => 'IMPS'}).should == [inward_remittance]
      find_inward_remittances({:req_transfer_type => 'NEFT'}).should == []
      
      inward_remittance = Factory(:inward_remittance,:transfer_type => 'NEFT')
      find_inward_remittances({:transfer_type => 'NEFT'}).should == [inward_remittance]
      find_inward_remittances({:transfer_type => 'IMPS'}).should == []
      
      inward_remittance = [Factory(:inward_remittance, :transfer_amount => '10000')]
      inward_remittance << Factory(:inward_remittance, :transfer_amount => '9000')
      inward_remittance << Factory(:inward_remittance, :transfer_amount => '8000')
      find_inward_remittances({:from_amount => '8000', :to_amount => '10000'}).should == inward_remittance
      find_inward_remittances({:from_amount => '10000', :to_amount => '12000'}).should == [inward_remittance[0]]
      
      inward_remittance = [Factory(:inward_remittance, :req_timestamp => '2015-04-25')]
      inward_remittance << Factory(:inward_remittance, :req_timestamp => '2015-04-26')
      inward_remittance << Factory(:inward_remittance, :req_timestamp => '2015-04-27')
      find_inward_remittances({:from_date => '2015-04-25', :to_date => '2015-04-27'}).should == inward_remittance
      find_inward_remittances({:from_date => '2015-04-28', :to_date => '2015-04-30'}).should == []
      
      
    end
  end
end