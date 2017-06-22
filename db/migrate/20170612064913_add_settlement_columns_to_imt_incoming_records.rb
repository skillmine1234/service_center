class AddSettlementColumnsToImtIncomingRecords < ActiveRecord::Migration
  def change
    add_column :imt_incoming_records, :settlement_at, :datetime, :comment => "the datetime when the settlement happened"
    add_column :imt_incoming_records, :settlement_status, :string, :limit => 15, :comment => "the settlement status of the IMT transaction"
    add_column :imt_incoming_records, :settlement_attempt_no, :integer, :comment => "the attempt number which has been made for IMT settlement"
    add_column :imt_incoming_records, :settlement_bank_ref, :string, :comment => "the unique reference no which has been sent to FCR api while doing settlement"    
    rename_column :imt_incoming_records, :amount, :transfer_amount
    change_column :imt_incoming_records, :issuing_bank, :string, :null => true
    change_column :imt_incoming_records, :acquiring_bank, :string, :null => true 
    change_column :imt_incoming_records, :imt_ref_no, :string, :null => true
    change_column :imt_incoming_records, :txn_issue_date, :datetime, :null => true
    change_column :imt_incoming_records, :txn_acquire_date, :datetime, :null => true
    change_column :imt_incoming_records, :chargeback_action_date, :datetime, :null => true
    change_column :imt_incoming_records, :issuing_bank_txn_id, :string, :null => true
    change_column :imt_incoming_records, :acquiring_bank_txn_id, :string, :null => true
    change_column :imt_incoming_records, :txn_status, :string, :null => true
    change_column :imt_incoming_records, :crdr, :string, :null => true
    change_column :imt_incoming_records, :transfer_amount, :number, :null => true
    change_column :imt_incoming_records, :acquiring_fee, :number, :null => true
    change_column :imt_incoming_records, :sc_on_acquiring_fee, :number, :null => true
    change_column :imt_incoming_records, :npci_charges, :number, :null => true
    change_column :imt_incoming_records, :sc_on_npci_charges, :number, :null => true
    change_column :imt_incoming_records, :total_net_position, :number, :null => true     
  end
end
