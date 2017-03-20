class IndexOnAdvancedSearchColumnsEcol < ActiveRecord::Migration
  def change
    add_index :ecol_transactions, [:customer_code, :transfer_unique_no, :status, :pending_approval, :notify_status,
                                    :validation_status, :settle_status, :transfer_type, :bene_account_no, :transfer_timestamp,
                                    :transfer_amt], name: 'ECOL_TRANSACTIONS_01'
  end
end
