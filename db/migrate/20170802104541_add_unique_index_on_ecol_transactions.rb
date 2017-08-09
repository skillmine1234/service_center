class AddUniqueIndexOnEcolTransactions < ActiveRecord::Migration
  def change
     if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
       remove_index :ecol_transactions, name: 'ecol_transaction_unique_index'
       add_index :ecol_transactions, [:transfer_unique_no, :transfer_type, :rmtr_account_ifsc], name: 'ecol_transactions_03'
       execute "CREATE UNIQUE INDEX ECOL_TRANSACTIONS_04 ON ECOL_TRANSACTIONS(CASE WHEN TRANSFER_TYPE !='NEFT' THEN TRANSFER_UNIQUE_NO END,CASE WHEN TRANSFER_TYPE !='NEFT' THEN TRANSFER_TYPE END) "                     
     end
  end
end