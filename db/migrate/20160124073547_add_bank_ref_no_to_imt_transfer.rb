class AddBankRefNoToImtTransfer < ActiveRecord::Migration
  def change
    add_column :imt_transfers, :initiation_bank_ref, :string, :null => false, :comment => "the unique ref no that was generated and sent to empays (imt) during initiate_transfer"
    add_column :imt_transfers, :cancellation_bank_ref, :string, :comment => "the unique ref no that was generated and sent to empays (imt) during cancel_transfer"
  end
end
