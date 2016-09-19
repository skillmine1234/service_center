require 'spec_helper'

describe PcProductsHelper do
  context "find_pc_products" do
    it "should find pc_products" do
      pc_product = Factory(:pc_product, :code => 'ABCD90', :approval_status => 'A')
      find_pc_products({:code => 'ABCD90'}).should == [pc_product]
      find_pc_products({:code => 'abcd90'}).should == [pc_product]
      find_pc_products({:code => 'Abcd90'}).should == [pc_product]
      find_pc_products({:code => 'Abcd 90'}).should == []
    end
  end
end
