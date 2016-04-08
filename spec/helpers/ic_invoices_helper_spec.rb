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

      ic_invoice = Factory(:ic_invoice, :invoice_no=> '2222')
      find_ic_invoices({:invoice_no => '2222'}).should == [ic_invoice]
      find_ic_invoices({:invoice_no => '2223'}).should == []

      ic_invoice = Factory(:ic_invoice, :credit_ref_no => '2222')
      find_ic_invoices({:credit_ref_no => '2222'}).should == [ic_invoice]
      find_ic_invoices({:credit_ref_no => '2223'}).should == []

      ic_invoice = Factory(:ic_invoice, :repayment_ref_no => '2222')
      find_ic_invoices({:repayment_ref_no => '2222'}).should == [ic_invoice]
      find_ic_invoices({:repayment_ref_no => '2223'}).should == []

      ic_invoice = Factory(:ic_invoice, :invoice_amount => 100)
      find_ic_invoices({:from_amount => 50, :to_amount => 200}).should == [ic_invoice]
      find_ic_invoices({:from_amount => 150, :to_amount => 200}).should == []

      ic_invoice = Factory(:ic_invoice, :invoice_date => Date.new(2016,4,15))
      find_ic_invoices({:from_date => "14-4-2016", :to_date => "16-4-2016"}).should == [ic_invoice]
      find_ic_invoices({:from_date => "13-4-2016", :to_date => "14-4-2016"}).should == []
    end
  end
end
