class AddBankRefNoToImtTransfer < ActiveRecord::Migration
  def self.up
    add_column :imt_transfers, :initiation_bank_ref, :string, :comment => "the unique ref no that was generated and sent to empays (imt) during initiate_transfer"
    add_column :imt_transfers, :cancellation_bank_ref, :string, :comment => "the unique ref no that was generated and sent to empays (imt) during cancel_transfer"
    change_column :imt_transfers, :initiation_bank_ref, :string, :null => false
  end
  def self.down
    remove_column :imt_transfers, :initiation_bank_ref
    remove_column :imt_transfers, :cancellation_bank_ref
  end
end
