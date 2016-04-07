require 'spec_helper'

describe IcInvoicesHelper do
  context "find_ic_invoices" do
    it "should find ic_invoices" do
      ic_invoice = Factory(:ic_invoice, :corp_customer_id => '1234')
      find_ic_invoices({:corp_customer_id => '1234'}).should == [ic_invoice]
      find_ic_invoices({:corp_customer_id => '1111'}).should == []
      
      ic_invoice = Factory(:ic_invoice, :supplier_code => '2222')
      find_ic_invoices({:supplier_code => '2222'}).should == [ic_invoice]
      find_ic_invoices({:supplier_code => '2223'}).should == []
    end
  end
end
