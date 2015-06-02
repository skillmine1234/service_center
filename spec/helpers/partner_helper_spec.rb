require 'spec_helper'

describe PartnerHelper do

  context 'find_partner'do
    it 'should return partners' do
      partner = Factory(:partner,:enabled => 'Y')
      find_partners({:enabled => 'Y'}).should == [partner]
      find_partners({:enabled => 'N'}).should == []
      partner = Factory(:partner,:code => '1231')
      find_partners({:code => '1231'}).should == [partner]
      find_partners({:code => '3211'}).should == []  
      partner = Factory(:partner,:account_no => '1234567891')
      find_partners({:account_no => '1234567891'}).should == [partner]
      find_partners({:account_no => '3212434323'}).should == []     
    end

    it 'should return partners' do  
      partner = Factory(:partner,:allow_neft => 'Y')
      find_partners({:allow_neft => 'Y'}).should == [partner]
      find_partners({:allow_neft => 'N'}).should == []  
      Partner.delete_all
      partner = Factory(:partner,:allow_rtgs => 'Y')
      find_partners({:allow_rtgs => 'Y'}).should == [partner]
      find_partners({:allow_rtgs => 'N'}).should == []  
      Partner.delete_all
      partner = Factory(:partner,:allow_imps => 'Y')
      find_partners({:allow_imps => 'Y'}).should == [partner]
      find_partners({:allow_imps => 'N'}).should == []  
    end
  end 
end