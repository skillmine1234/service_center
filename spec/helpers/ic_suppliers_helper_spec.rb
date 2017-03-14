require 'spec_helper'

describe IcSuppliersHelper do
  include HelperMethods

  before(:each) do
    mock_ldap
  end
  
  context "find_ic_suppliers" do
    it "should find ic_suppliers" do
      ic_supplier = Factory(:ic_supplier, :supplier_code => '2233', :approval_status => "A")
      find_ic_suppliers({:supplier_code => '2233'}).should == [ic_supplier]
      find_ic_suppliers({:supplier_code => '2234'}).should == []
      
      ic_supplier = Factory(:ic_supplier, :supplier_name => "MyString1", :approval_status => "A")
      find_ic_suppliers({:supplier_name => 'MyString1'}).should == [ic_supplier]
      find_ic_suppliers({:supplier_name => 'MyString2'}).should == []

      ic_supplier = Factory(:ic_supplier, :supplier_name => "MyString2", :approval_status => "A")
      find_ic_suppliers({:supplier_name => 'myString2'}).should == [ic_supplier]
      find_ic_suppliers({:supplier_name => 'mystring2'}).should == [ic_supplier]
      find_ic_suppliers({:supplier_name => 'MYSTRING2'}).should == [ic_supplier]
      find_ic_suppliers({:supplier_name => 'mystring3'}).should == []
      find_ic_suppliers({:supplier_name => 'MyString3'}).should == []
    end
  end  
end
