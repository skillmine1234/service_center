class IndexOnAdvancedSearchColumnsFt < ActiveRecord::Migration[7.0]
  def change
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      add_index :funds_transfers, [:customer_id, :req_no, :attempt_no, :status_code, :bank_ref, :debit_account_no, :bene_account_no,
                                   :req_transfer_type, :transfer_type, :transfer_amount, :req_timestamp, :rep_timestamp],
                                   name: 'FUNDS_TRANSFERS_01'
    end
  end
end
