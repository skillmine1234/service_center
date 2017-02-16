require 'spec_helper'

describe IdentitiesHelper do
  context 'find_identities'do
    it 'should return identities' do
      partner = Factory(:partner,:enabled => 'Y', :approval_status => 'A', :code => 'a123')
      identity = Factory(:whitelisted_identity, :partner_id => partner.id, :approval_status => 'A')
      find_identities({:code => 'a123'}).should == [identity]
      find_identities({:code => 'A123'}).should == []
      find_identities({:code => 'ab123'}).should == []
      identity = Factory(:whitelisted_identity, :full_name => 'foobar', :approval_status => 'A', :id_type => 'driving license')
      find_identities({:name => 'foobar'}).should == [identity]
      find_identities({:name => 'foo'}).should == []
      find_identities({:name => 'bar'}).should == []
      identity = Factory(:whitelisted_identity, :rmtr_code => 'foobar', :approval_status => 'A', :id_type => 'passport')
      find_identities({:rmtr_code => 'foobar'}).should == [identity]
      find_identities({:rmtr_code => 'foo'}).should == []
      find_identities({:rmtr_code => 'bar'}).should == []
      identity = Factory(:whitelisted_identity, :bene_account_no => '987654320987', :approval_status => 'A', :id_type => 'pan')
      find_identities({:bene_account_no => '987654320987'}).should == [identity]
      find_identities({:bene_account_no => 'foo'}).should == []
      find_identities({:bene_account_no => 'bar'}).should == []
      identity = Factory(:whitelisted_identity, :bene_account_ifsc => 'ABCD0123456', :approval_status => 'A', :id_type => 'aadhar')
      find_identities({:bene_account_ifsc => 'ABCD0123456'}).should == [identity]
      find_identities({:bene_account_ifsc => 'ABCD'}).should == []
      find_identities({:bene_account_ifsc => 'abc'}).should == []
    end
  end 
end