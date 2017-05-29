class AddPurposeCodeToFundsTransfers < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      add_column :funds_transfers, :purpose_code, :string, :limit => 20, :comment => "the purpose code of the transaction"    
    end    
  end
end