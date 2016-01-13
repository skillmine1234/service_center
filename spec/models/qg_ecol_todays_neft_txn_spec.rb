require 'spec_helper'

describe QgEcolTodaysNeftTxn do
  
  context 'validation' do
    [:ref_txn_no, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date].each do |att|
      it { should validate_presence_of(att) }
    end

    it "should validate IFSC format" do
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => "ABCD0123456", :rmtr_account_ifsc => "QWER0123456")
      qg_ecol_todays_neft_txn.should be_valid
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => "abcd0QWERTY", :rmtr_account_ifsc => "abcd0QWERTY")
      qg_ecol_todays_neft_txn.should_not be_valid
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => "abcdQWERTY", :rmtr_account_ifsc => "abcdQWERTY")
      qg_ecol_todays_neft_txn.should_not be_valid
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => "ab0QWER", :rmtr_account_ifsc => "ab0QWER")
      qg_ecol_todays_neft_txn.should_not be_valid
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => "ab@#0QWER", :rmtr_account_ifsc => "ab@#0QWER")
      qg_ecol_todays_neft_txn.should_not be_valid
    end
    
    it "should validate uniqueness of transfer_unique_no" do
      qg_ecol_todays_neft_txn = Factory(:qg_ecol_todays_neft_txn)
      should validate_uniqueness_of(:transfer_unique_no)
    end
  end
  
  context "set_default_values" do
    it "should set default_values" do
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn)
      qg_ecol_todays_neft_txn.transfer_type.should == 'MyString'
      qg_ecol_todays_neft_txn.transfer_ccy.should == 'MyString'
      qg_ecol_todays_neft_txn.transfer_status.should == 'MyString'
      qg_ecol_todays_neft_txn.save
      qg_ecol_todays_neft_txn.transfer_type.should == 'NEFT'
      qg_ecol_todays_neft_txn.transfer_ccy.should == 'INR'
      qg_ecol_todays_neft_txn.transfer_status.should == '30'
    end
  end
  
  context "set_ref_txn_no" do
    it "should set ref_txn_no" do
      qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :ref_txn_no => "MyString1")
      qg_ecol_todays_neft_txn.ref_txn_no.should == 'MyString1'
      qg_ecol_todays_neft_txn.save
      qg_ecol_todays_neft_txn.ref_txn_no.should == qg_ecol_todays_neft_txn.id.to_s
    end
  end
  
end
