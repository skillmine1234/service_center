class MergeIsCreditIsDebitIntoOneForPcIncomingRecords < ActiveRecord::Migration
  def self.up
    remove_column :pc_incoming_records, :is_credit
    remove_column :pc_incoming_records, :is_debit
    rename_column :pc_incoming_records, :program_code, :app_id
    add_column :pc_incoming_records, :crdr, :string, :limit => 1, :comment => 'the crdr indicator for the transaction'
  end
  def self.down
    remove_column :pc_incoming_records, :crdr
    rename_column :pc_incoming_records, :app_id, :program_code
    add_column :pc_incoming_records, :is_credit, :string, :limit => 20, :comment => "the indicator to show whether the credit has to be done"
    add_column :pc_incoming_records, :is_debit, :string, :limit => 20, :comment => "the indicator to show whether the debit has to be done"
  end
end
