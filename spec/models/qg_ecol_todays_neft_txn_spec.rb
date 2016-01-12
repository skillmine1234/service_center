require 'spec_helper'

describe QgEcolTodaysNeftTxn do
  
  context 'validation' do
    [:ref_txn_no, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date].each do |att|
      it { should validate_presence_of(att) }
    end 
  end
  
end
