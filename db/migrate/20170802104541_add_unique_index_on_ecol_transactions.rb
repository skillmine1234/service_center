class AddUniqueIndexOnEcolTransactions < ActiveRecord::Migration
  def change
     if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
       execute "DROP INDEX ECOL_TRANSACTION_UNIQUE_INDEX "
       execute "CREATE UNIQUE INDEX ECOL_TRANSACTION_UNIQUE_INDEX ON ECOL_TRANSACTIONS (TRANSFER_UNIQUE_NO,TRANSFER_TYPE,RMTR_ACCOUNT_IFSC) "
       execute "CREATE UNIQUE INDEX ECOL_TRANSACTION_UNIQUE_1 ON ECOL_TRANSACTIONS(CASE WHEN TRANSFER_TYPE !='NEFT' THEN TRANSFER_UNIQUE_NO END,CASE WHEN TRANSFER_TYPE !='NEFT' THEN TRANSFER_TYPE END) "                     
     end
  end
end