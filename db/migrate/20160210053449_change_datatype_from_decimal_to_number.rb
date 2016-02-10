class ChangeDatatypeFromDecimalToNumber < ActiveRecord::Migration
  def change   
    columns = [ {"table" => "bm_aggregator_payments", 
                 "column" => "payment_amount", 
                 "comment" => "the amount paid to the aggregator",
                 "nullable" => true},
                 
                 {"table" => "bm_bill_payments", 
                 "column" => "txn_amount", 
                 "comment" => "the transaction amount", 
                 "nullable" => false}, 
               
                 {"table" => "bm_pay_to_biller_accts", 
                 "column" => "payment_amount", 
                 "comment" => "the amount to be paid, requirement if payment is without a bill",
                 "nullable" => true},
               
                 {"table" => "bm_pay_to_biller_accts", 
                 "column" => "bill_amount", 
                 "comment" => "the bill amount, required if payment is towards a bill",
                 "nullable" => true},
                 
                 {"table" => "bm_pay_to_billers", 
                 "column" => "bill_amount", 
                 "comment" => "the bill amount, required if payment is towards a bill",
                 "nullable" => true},
                 
                 {"table" => "bm_pay_to_billers", 
                 "column" => "payment_amount", 
                 "comment" => "the amount to be paid, requirement if payment is without a bill",
                 "nullable" => true},
                 
                 {"table" => "pc_customers", 
                 "column" => "available_funds", 
                 "comment" => "the available funds in card", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier3_max_sc_amt", 
                 "comment" => "the max fee amount, when pct is applied for tier 3", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier3_min_sc_amt", 
                 "comment" => "the min fee amount, when pct is applied for tier 3", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier3_pct_value", 
                 "comment" => "the pct value for tier 3", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier3_fixed_amt", 
                 "comment" => "the fixed fee amount for tier 3", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier2_max_sc_amt", 
                 "comment" => "the max fee amount, when pct is applied for tier 2", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier2_min_sc_amt", 
                 "comment" => "the min fee amount, when pct is applied for tier 2", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier2_pct_value", 
                 "comment" => "the pct value for tier 2", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier2_fixed_amt", 
                 "comment" => "the fixed fee amount for tier 2", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier2_to_amt", 
                 "comment" => "the to amount (exclusive) for tier 2", 
                 "nullable" => true},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier1_max_sc_amt", 
                 "comment" => "the max fee amount, when pct is applied for tier 1", 
                 "nullable" => false},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier1_min_sc_amt", 
                 "comment" => "the min fee amount, when pct is applied for tier 1", 
                 "nullable" => false},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier1_pct_value", 
                 "comment" => "the pct value for tier 1", 
                 "nullable" => false},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier1_fixed_amt", 
                 "comment" => "the fixed fee amount for tier 1", 
                 "nullable" => false},
                 
                 {"table" => "pc_fee_rules", 
                 "column" => "tier1_to_amt", 
                 "comment" => "the to amount (exclusive) for tier 1", 
                 "nullable" => false},
                 
                 {"table" => "pc_load_cards", 
                 "column" => "load_amount", 
                 "comment" => "the amount value which will be load to the card", 
                 "nullable" => true},
                 
                 {"table" => "pcs_pay_to_accounts", 
                 "column" => "service_charge", 
                 "comment" => "the service charge applied for the transaction, exclusive of tax", 
                 "nullable" => true},
                 
                 {"table" => "pcs_pay_to_contacts", 
                 "column" => "service_charge", 
                 "comment" => "the service charge applied for the transaction, exclusive of tax", 
                 "nullable" => true},
                 
                 {"table" => "pcs_top_ups", 
                 "column" => "service_charge", 
                 "comment" => "the service charge applied for the transaction, exclusive of tax", 
                 "nullable" => true},
                 
                 {"table" => "pcs_top_ups", 
                 "column" => "transfer_amount", 
                 "comment" => "the transfer amount", 
                 "nullable" => true},
                 
                 {"table" => "imt_initiate_transfers", 
                 "column" => "transfer_amount", 
                 "comment" => "the transfer amount", 
                 "nullable" => false},
                 
                 {"table" => "imt_transfers", 
                 "column" => "transfer_amount", 
                 "comment" => "the transfer amount", 
                 "nullable" => false}
               ]
               
    columns.each do |col|
      a = col["column"]
      add_column col["table"].to_sym, "#{a}_copy".to_sym, :number, :null => col["nullable"], :comment => col["comment"]
      db.execute("UPDATE #{col["table"]} SET #{a}_copy=#{a}")
      remove_column col["table"].to_sym, a.to_sym
      rename_column col["table"].to_sym, "#{a}_copy".to_sym, a.to_sym
    end
  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
  
end
