require 'spec_helper'

describe QgEcolTodaysRtgsTxn do
  
  context 'validation' do
    [:idfcatref, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date].each do |att|
      it { should validate_presence_of(att) }
    end

    context "ifsc format" do 
      it "should validate the format of bene_account_ifsc and rmtr_account_ifsc" do 
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A", :transfer_amt => 200000)
        qg_ecol_todays_rtgs_txn.should be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd0dsg34', :rmtr_account_ifsc => "ABcd0dsg34", :transfer_amt => 200001)
        qg_ecol_todays_rtgs_txn.should_not be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd4dsg34A', :rmtr_account_ifsc => "ABcd4dsg34A", :transfer_amt => 199999)
        qg_ecol_todays_rtgs_txn.should_not be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd0dsg34$', :rmtr_account_ifsc => "ABcd0dsg34", :transfer_amt => 300000)
        qg_ecol_todays_rtgs_txn.should_not be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABc@0dsg34A', :rmtr_account_ifsc => "ABc@0dsg34A", :transfer_amt => 300001)
        qg_ecol_todays_rtgs_txn.should_not be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABc@@dsg34A', :rmtr_account_ifsc => "ABc@@dsg34A", :transfer_amt => 200000)
        qg_ecol_todays_rtgs_txn.should_not be_valid
      end
    end

    context "transfer_amt" do
      it "should validate transfer_amt" do
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A", :transfer_amt => 200001)
        qg_ecol_todays_rtgs_txn.should be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A", :transfer_amt => 200000)
        qg_ecol_todays_rtgs_txn.should be_valid
        qg_ecol_todays_rtgs_txn = Factory.build(:qg_ecol_todays_rtgs_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A", :transfer_amt => 199999)
        qg_ecol_todays_rtgs_txn.should_not be_valid
      end
    end

  end

end
