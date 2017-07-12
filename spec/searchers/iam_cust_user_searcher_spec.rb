require 'spec_helper'
require 'flexmock/test_unit'

describe IamCustUserSearcher do
  include HelperMethods
  before(:each) do
    mock_ldap
  end

  context 'searcher' do
    it 'should return iam_cust_user records' do      
      iam_cust_user = Factory(:iam_cust_user, :username => 'user_123', :approval_status => 'A')
      IamCustUserSearcher.new({:username => 'user_123'}).paginate.should == [iam_cust_user]
      IamCustUserSearcher.new({:username => 'user.234'}).paginate.should == []
      
      iam_cust_user = Factory(:iam_cust_user, :mobile_no => '9999888899', :approval_status => 'A')
      IamCustUserSearcher.new({:mobile_no => '9999888899'}).paginate.should == [iam_cust_user]
      IamCustUserSearcher.new({:mobile_no => '9999000099'}).paginate.should == []

      iam_cust_user = Factory(:iam_cust_user, :email => 'george@testmail.com', :approval_status => 'A')
      IamCustUserSearcher.new({:email => 'george@testmail.com'}).paginate.should == [iam_cust_user]
      IamCustUserSearcher.new({:email => 'merin@testmail.com'}).paginate.should == []
    end
  end
end