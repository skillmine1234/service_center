class AddReqTransferTypeToInwardRemittances < ActiveRecord::Migration
  def change
    add_column :inward_remittances, :req_transfer_type, :string
  end
end
