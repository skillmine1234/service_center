class AlterFundsTransferBasisOnCustomer < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      add_column :funds_transfers, :purpose_code, :string, :limit => 20, :comment => "the purpose code of the transaction"    
    end    
    add_column :ft_customers, :is_store_and_frwd, :string, :limit => 1, :default => 'N', :null => false, :comment => "the identifier to specify is the request has to be stored and process later or process immediate without storing"    
  end
end