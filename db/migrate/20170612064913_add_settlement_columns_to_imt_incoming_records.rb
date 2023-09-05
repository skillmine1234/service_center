class AddSettlementColumnsToImtIncomingRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :imt_incoming_records, :settlement_at, :datetime, :comment => "the datetime when the settlement happened"
    add_column :imt_incoming_records, :settlement_status, :string, :limit => 15, :comment => "the settlement status of the IMT transaction"
    add_column :imt_incoming_records, :settlement_attempt_no, :integer, :comment => "the attempt number which has been made for IMT settlement"
    add_column :imt_incoming_records, :settlement_bank_ref, :string, :comment => "the unique reference no which has been sent to FCR api while doing settlement"
    #rename_column :imt_incoming_records, :amount, :transfer_amount
    change_column :imt_incoming_records, :issuing_bank, :string, :null => true, :comment => "the name of the bank which issued"
    change_column :imt_incoming_records, :acquiring_bank, :string, :null => true, :comment => "the name of the bank that processes payments on behalf of merchant"
    change_column :imt_incoming_records, :imt_ref_no, :string, :null => true, :comment => "the unique reference no through which imt has been initiated"
    change_column :imt_incoming_records, :txn_issue_date, :datetime, :null => true, :comment => "the timestamp of the transaction when it has been issued"
    change_column :imt_incoming_records, :txn_acquire_date, :datetime, :null => true, :comment => "the timestamp when the transaction was created"
    change_column :imt_incoming_records, :chargeback_action_date, :datetime, :null => true, :comment => "the timestamp of the return of funds to a consumer, forcibly initiated by the issuing bank of the instrument used by a consumer to settle a debt"
    change_column :imt_incoming_records, :issuing_bank_txn_id, :string, :null => true, :comment => "the transaction id of the bank which issued"
    change_column :imt_incoming_records, :acquiring_bank_txn_id, :string, :null => true, :comment => "the transaction id of the acquiring bank"
    change_column :imt_incoming_records, :txn_status, :string, :null => true, :comment => "the status of the imt transaction"
    change_column :imt_incoming_records, :crdr, :string, :null => true, :comment => "the flag that indicates either debited or credited"
    #change_column :imt_incoming_records, :transfer_amount, :number, :null => true, :comment => "the amount which has been transferred"
    #change_column :imt_incoming_records, :acquiring_fee, :number, :null => true, :comment => "the card-issuing bank deducts the interchange fee from the amount it pays the acquiring bank that handles a credit or debit card transaction for a customer"
    #change_column :imt_incoming_records, :sc_on_acquiring_fee, :number, :null => true, :comment => "service charge on acquiring fee"
    #change_column :imt_incoming_records, :npci_charges, :number, :null => true, :comment => "the amount charged by NPCI for processing"
    #change_column :imt_incoming_records, :sc_on_npci_charges, :number, :null => true, :comment => "the service charge on npci charges"
    #change_column :imt_incoming_records, :total_net_position, :number, :null => true, :comment => "the value of the position subtracting the initial cost of setting up the position"
  end
end
