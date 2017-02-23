require 'spec_helper'

describe IdentitiesHelper do
  # context 'find_identities'do
  #   it 'should return identities' do
  #     partner = Factory(:partner,:enabled => 'Y', will_send_id: 'N', :approval_status => 'A', :code => 'a123')
  #     inward_remittance = Factory(:inward_remittance, partner_code: partner.code, rmtr_full_name: 'MyString', rmtr_code: 'MyString')
  #     identity = Factory(:whitelisted_identity, :partner_id => partner.id, created_for_req_no: inward_remittance.req_no, full_name: 'MyString', rmtr_code: 'MyString', :approval_status => 'A')
  #     find_identities({:code => 'a123'}).should == [identity]
  #     find_identities({:code => 'A123'}).should == []
  #     find_identities({:code => 'ab123'}).should == []
  #
  #     inward_remittance = Factory(:inward_remittance, partner_code: partner.code, rmtr_full_name: 'MyString', rmtr_code: 'MyString')
  #     identity = Factory(:whitelisted_identity, :full_name => 'foobar', :approval_status => 'A', :id_type => 'driving license', rmtr_code: 'MyString')
  #     find_identities({:name => 'foobar'}).should == [identity]
  #     find_identities({:name => 'foo'}).should == []
  #     find_identities({:name => 'bar'}).should == []
  #
  #     identity = Factory(:whitelisted_identity, :approval_status => 'A', :id_type => 'passport', full_name: 'MyString', rmtr_code: 'MyString')
  #     find_identities({:rmtr_code => 'MyString'}).should == [identity]
  #     find_identities({:rmtr_code => 'My'}).should == []
  #     find_identities({:rmtr_code => 'String'}).should == []
  #
  #     identity = Factory(:whitelisted_identity, :bene_account_no => '987654320987', :approval_status => 'A', :id_type => 'pan', full_name: 'MyString', rmtr_code: 'MyString')
  #     find_identities({:bene_account_no => '987654320987'}).should == [identity]
  #     find_identities({:bene_account_no => 'foo'}).should == []
  #     find_identities({:bene_account_no => 'bar'}).should == []
  #
  #     identity = Factory(:whitelisted_identity, :bene_account_ifsc => 'ABCD0123456', :approval_status => 'A', :id_type => 'aadhar', full_name: 'MyString', rmtr_code: 'MyString')
  #     find_identities({:bene_account_ifsc => 'ABCD0123456'}).should == [identity]
  #     find_identities({:bene_account_ifsc => 'ABCD'}).should == []
  #     find_identities({:bene_account_ifsc => 'abc'}).should == []
  #   end
  # end
end