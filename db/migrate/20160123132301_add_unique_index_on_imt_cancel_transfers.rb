class AddUniqueIndexOnImtCancelTransfers < ActiveRecord::Migration
  def change
    add_index :imt_cancel_transfers, :bank_ref_no, :unique => true
  end
end
