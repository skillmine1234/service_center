require 'spec_helper'

describe ReconciledReturn do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:txn_type, :return_code_type, :return_code, :settlement_date, :bank_ref_no, :reason].each do |att|
      it { should validate_presence_of(att) }
    end

    it { 
      Factory(:reconciled_return)
      should validate_uniqueness_of(:bank_ref_no).scoped_to(:txn_type)
    }
  end
  
  context "options_for_txn_type" do
    it "should return options for txn_type" do
      ReconciledReturn.options_for_txn_type.should == [['NEFT','NEFT'],['RTGS','RTGS'],['IMPS','IMPS']]
    end
  end

  context "set_return_code" do
    it "should set return_code for a record" do
      rr1 = Factory(:reconciled_return, txn_type: 'NEFT', return_code_type: 'COMPLETED')
      rr1.return_code.should == '75'
      rr2 = Factory(:reconciled_return, txn_type: 'NEFT', return_code_type: 'FAILED')
      rr2.return_code.should == '99'
      rr3 = Factory(:reconciled_return, txn_type: 'RTGS', return_code_type: 'COMPLETED')
      rr3.return_code.should == 'COM'
      rr4 = Factory(:reconciled_return, txn_type: 'RTGS', return_code_type: 'FAILED')
      rr4.return_code.should == 'REJ'
      rr5 = Factory(:reconciled_return, txn_type: 'IMPS', return_code_type: 'COMPLETED')
      rr5.return_code.should == '00'
      rr6 = Factory(:reconciled_return, txn_type: 'IMPS', return_code_type: 'FAILED')
      rr6.return_code.should == '08'
    end
  end
end
