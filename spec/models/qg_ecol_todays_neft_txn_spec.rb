require 'spec_helper'

describe QgEcolTodaysNeftTxn do
  
  context 'validation' do
    [:ref_txn_no, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date].each do |att|
      it { should validate_presence_of(att) }
    end

    context "ifsc format" do 
      it "should validate the format of bene_account_ifsc" do 
        qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A")
        qg_ecol_todays_neft_txn.should be_valid
        qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABcd0dsg34', :rmtr_account_ifsc => "ABcd0dsg34")
        qg_ecol_todays_neft_txn.should_not be_valid
        qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABcd4dsg34A', :rmtr_account_ifsc => "ABcd4dsg34A")
        qg_ecol_todays_neft_txn.should_not be_valid
        qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABcd0dsg34$', :rmtr_account_ifsc => "ABcd0dsg34")
        qg_ecol_todays_neft_txn.should_not be_valid
        qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABc@0dsg34A', :rmtr_account_ifsc => "ABc@0dsg34A")
        qg_ecol_todays_neft_txn.should_not be_valid
        qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABc@@dsg34A', :rmtr_account_ifsc => "ABc@@dsg34A")
        qg_ecol_todays_neft_txn.should_not be_valid
      end
    end

    # context "transfer_amt" do
    #   it "should validate transfer_amt" do
    #     qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A", :transfer_amt => 200001)
    #     qg_ecol_todays_neft_txn.should be_valid
    #     qg_ecol_todays_neft_txn = Factory.build(:qg_ecol_todays_neft_txn, :bene_account_ifsc => 'ABcd0dsg34A', :rmtr_account_ifsc => "ABcd0dsg34A", :transfer_amt => 200001)
    #     qg_ecol_todays_neft_txn.should_not be_valid
    #   end
    # end

  end
  
end
