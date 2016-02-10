class ChangeDatatypeFromDecimalToNumber < ActiveRecord::Migration
  def change
    change_column :bm_aggregator_payments, :payment_amount, :number
    change_column :bm_bill_payments, :txn_amount, :number
    change_column :bm_pay_to_biller_accts, :payment_amount, :number
    change_column :bm_pay_to_biller_accts, :bill_amount, :number
    change_column :bm_pay_to_billers, :bill_amount, :number
    change_column :pc_customers, :available_funds, :number
    change_column :pc_fee_rules, :tier3_max_sc_amt, :number
    change_column :pc_fee_rules, :tier3_min_sc_amt, :number
    change_column :pc_fee_rules, :tier3_pct_value, :number
    change_column :pc_fee_rules, :tier3_fixed_amt, :number
    change_column :pc_fee_rules, :tier2_max_sc_amt, :number
    change_column :pc_fee_rules, :tier2_min_sc_amt, :number
    change_column :pc_fee_rules, :tier2_pct_value, :number
    change_column :pc_fee_rules, :tier2_fixed_amt, :number
    change_column :pc_fee_rules, :tier2_to_amt, :number
    change_column :pc_fee_rules, :tier1_max_sc_amt, :number
    change_column :pc_fee_rules, :tier1_min_sc_amt, :number
    change_column :pc_fee_rules, :tier1_pct_value, :number
    change_column :pc_fee_rules, :tier1_fixed_amt, :number
    change_column :pc_fee_rules, :tier1_to_amt, :number
    change_column :pc_load_cards, :load_amount, :number
    change_column :pcs_pay_to_accounts, :service_charge, :number
    change_column :pcs_pay_to_contacts, :service_charge, :number
    change_column :pcs_top_ups, :service_charge, :number
    change_column :pcs_top_ups, :transfer_amount, :number
    change_column :imt_initiate_transfers, :transfer_amount, :number
    change_column :imt_transfers, :transfer_amount, :number
  end
end
