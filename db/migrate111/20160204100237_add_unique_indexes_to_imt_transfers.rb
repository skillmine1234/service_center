class AddUniqueIndexesToImtTransfers < ActiveRecord::Migration[7.0]
  def change
    add_index :imt_transfers, [:imt_ref_no], :unique => true, :name => "uk_imt_transfers_1"
    add_index :imt_transfers, [:initiation_ref_no], :unique => true, :name => "uk_imt_transfers_2"
    add_index :imt_transfers, [:cancellation_ref_no], :unique => true, :name => "uk_imt_transfers_3"
    
  end
end
