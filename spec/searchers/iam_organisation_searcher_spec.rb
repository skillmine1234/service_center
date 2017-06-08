require 'spec_helper'
require 'flexmock/test_unit'

describe IamOrganisationSearcher do
  include HelperMethods
  before(:each) do
    mock_ldap
  end

  context 'searcher' do
    it 'should return iam_organisation records' do      
      iam_organisation = Factory(:iam_organisation, :name => 'ABC DEF', :approval_status => 'A')
      IamOrganisationSearcher.new({:name => 'ABC DEF'}).paginate.should == [iam_organisation]
      IamOrganisationSearcher.new({:name => 'AB DEF'}).paginate.should == []
      
      iam_organisation = Factory(:iam_organisation, :org_uuid => 'UUID88899', :approval_status => 'A')
      IamOrganisationSearcher.new({:org_uuid => 'UUID88899'}).paginate.should == [iam_organisation]
      IamOrganisationSearcher.new({:org_uuid => 'UUID88099'}).paginate.should == []      
    end
  end
end