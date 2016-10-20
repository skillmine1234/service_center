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
    end
  end 
end