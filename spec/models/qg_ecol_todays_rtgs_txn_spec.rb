require 'spec_helper'

describe QgEcolTodaysRtgsTxn do
  
  context 'validation' do
    [:idfcatref, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date].each do |att|
      it { should validate_presence_of(att) }
    end
    
    it "should validate IFSC format" do
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => "ABCD0123456", :rmtr_account_ifsc => "QWER0123456")
      qg_ecol_todays_rtgs_txn.should be_valid
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => "abcd0QWERTY", :rmtr_account_ifsc => "abcd0QWERTY")
      qg_ecol_todays_rtgs_txn.should_not be_valid
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => "abcdQWERTY", :rmtr_account_ifsc => "abcdQWERTY")
      qg_ecol_todays_rtgs_txn.should_not be_valid
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => "ab0QWER", :rmtr_account_ifsc => "ab0QWER")
      qg_ecol_todays_rtgs_txn.should_not be_valid
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => "ab@#0QWER", :rmtr_account_ifsc => "ab@#0QWER")
      qg_ecol_todays_rtgs_txn.should_not be_valid
    end

    it "should validate transfer_amt" do
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :transfer_amt => 200001)
      qg_ecol_todays_rtgs_txn.should be_valid
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :transfer_amt => 200000)
      qg_ecol_todays_rtgs_txn.should be_valid
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :transfer_amt => 199999)
      qg_ecol_todays_rtgs_txn.should_not be_valid
    end
  end
    
  context "set_default_values" do
    it "should set default_values" do
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn)
      qg_ecol_todays_rtgs_txn.transfer_type.should == 'MyString'
      qg_ecol_todays_rtgs_txn.transfer_ccy.should == 'MyString'
      qg_ecol_todays_rtgs_txn.transfer_status.should == 'MyString'
      qg_ecol_todays_rtgs_txn.save
      qg_ecol_todays_rtgs_txn.transfer_type.should == 'RTGS'
      qg_ecol_todays_rtgs_txn.transfer_ccy.should == 'INR'
      qg_ecol_todays_rtgs_txn.transfer_status.should == 'COM'
    end
  end

  context "set_idfactno" do
    it "should set idfactno" do
      qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :idfcatref => "MyString1")
      qg_ecol_todays_rtgs_txn.idfcatref.should == 'MyString1'
      qg_ecol_todays_rtgs_txn.save
      qg_ecol_todays_rtgs_txn.idfcatref.should == qg_ecol_todays_rtgs_txn.id.to_s
    end
  end
end
