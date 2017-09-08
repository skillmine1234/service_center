require 'spec_helper'

describe SspBankSearcher do

  context 'searcher' do
    it 'should return ssp_bank records' do      
      ssp_bank = Factory(:ssp_bank, :app_code => 'app-123', :approval_status => 'A')
      SspBankSearcher.new({:app_code => 'app-123'}).paginate.should == [ssp_bank]
      SspBankSearcher.new({:app_code => 'app.234'}).paginate.should == []
      
      ssp_bank = Factory(:ssp_bank, :customer_code => '2424', :approval_status => 'A')
      SspBankSearcher.new({:customer_code => '2424'}).paginate.should == [ssp_bank]
      SspBankSearcher.new({:customer_code => '000000000'}).paginate.should == []
    end
  end
end