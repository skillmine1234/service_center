class CreateTableFrR01IncomingRecords < ActiveRecord::Migration
  def change
    create_table :fr_r01_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table" 
      t.string  :file_name, :limit => 100, :comment => "the name of the incoming_file"     
      t.string  :account_no, :limit => 100, :comment => "the account no which comes in input file for balance enquiry"
      t.number  :available_balance, :comment => "the available balance of the given account number"
      t.number  :onhold_amount, :comment => "the  onhold amount for the given account number"
      t.number  :sweepin_balance, :comment => "the sweepin balance for the given account number"
      t.number  :overdraft_limit, :comment => "the :overdraft limit for the given account number"
      t.number  :total_balance, :comment => "the total balance for the given account number"
      t.string  :customer_name, :comment => "the customer name for given account number"
      t.index([:incoming_file_record_id,:file_name], :unique => true, :name => 'fr_r01_incoming_records_01')        
    end
  end
end
