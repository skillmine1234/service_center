require 'spec_helper'

describe BmBillPayment do
  context 'association' do
    it { should have_many(:bm_billpay_steps) }
  end

  context 'validation' do
    [:app_id, :req_no, :attempt_no, :customer_id, :debit_account_no, :txn_kind,
                        :txn_amount, :status].each do |att|
      it { should validate_presence_of(att) }
    end
  end
  
end