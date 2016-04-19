require 'spec_helper'

describe IcInvoicesHelper do
  context "find_ic_invoices" do
    it "should find ic_invoices" do
      ic_invoice1 = Factory(:ic_invoice, :corp_customer_id => '1234')
      find_ic_invoices({:corp_customer_id => '1234'}).should == [ic_invoice1]
      find_ic_invoices({:corp_customer_id => '1111'}).should == []
      
      ic_invoice2 = Factory(:ic_invoice, :supplier_code => '2222')
      find_ic_invoices({:supplier_code => '2222'}).should == [ic_invoice2]
      find_ic_invoices({:supplier_code => '2223'}).should == []

      ic_invoice3 = Factory(:ic_invoice, :invoice_no=> '2222')
      find_ic_invoices({:invoice_no => '2222'}).should == [ic_invoice3]
      find_ic_invoices({:invoice_no => '2223'}).should == []

      ic_invoice4 = Factory(:ic_invoice, :credit_ref_no => '2222')
      find_ic_invoices({:credit_ref_no => '2222'}).should == [ic_invoice4]
      find_ic_invoices({:credit_ref_no => '2223'}).should == []

      ic_invoice5 = Factory(:ic_invoice, :invoice_amount => 100)
      find_ic_invoices({:from_amount => 50, :to_amount => 200}).should == [ic_invoice5]
      find_ic_invoices({:from_amount => 150, :to_amount => 200}).should == []

      ic_invoice6 = Factory(:ic_invoice, :invoice_amount => 100000)
      ic_invoice7 = Factory(:ic_invoice, :invoice_amount => 200000)
      find_ic_invoices({:from_amount => 10000, :to_amount => nil}).should == [ic_invoice1, ic_invoice2, ic_invoice3, ic_invoice4, ic_invoice6, ic_invoice7]

      ic_invoice8 = Factory(:ic_invoice, :invoice_amount => 5000)
      ic_invoice9 = Factory(:ic_invoice, :invoice_amount => 10000)
      ic_invoice10 = Factory(:ic_invoice, :invoice_amount => 20000)
      ic_invoice11 = Factory(:ic_invoice, :invoice_amount => 30000)
      find_ic_invoices({:from_amount => nil, :to_amount => 20000}).should == [ic_invoice5, ic_invoice8, ic_invoice9, ic_invoice10]

      ic_invoice = Factory(:ic_invoice, :invoice_date => Date.new(2016,4,15))
      find_ic_invoices({:from_date => "14-4-2016", :to_date => "16-4-2016"}).should == [ic_invoice]
      find_ic_invoices({:from_date => "13-4-2016", :to_date => "14-4-2016"}).should == []
    end
  end
end
