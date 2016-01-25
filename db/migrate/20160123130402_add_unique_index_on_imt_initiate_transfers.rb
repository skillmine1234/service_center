class AddUniqueIndexOnImtInitiateTransfers < ActiveRecord::Migration
  def change
    add_index :imt_initiate_transfers, :bank_ref_no, :unique => true
  end
end
