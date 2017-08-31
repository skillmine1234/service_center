class AddUniqueIndexForEcolTransactions < ActiveRecord::Migration
  def change
     if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
       remove_index :ecol_transactions, name: 'ecol_transactions_03'
       add_index :ecol_transactions, [:transfer_unique_no, :transfer_type, :rmtr_account_ifsc], name: 'ecol_transactions_03', :unique => true
     end
  end
end