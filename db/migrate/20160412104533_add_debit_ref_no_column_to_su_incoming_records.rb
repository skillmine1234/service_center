class AddDebitRefNoColumnToSuIncomingRecords < ActiveRecord::Migration
  def change
   add_column :su_incoming_records, :debit_ref_no, :string, :limit => 20, :comment => "the reference no of the debit will be seen in the statement"
  end
end
