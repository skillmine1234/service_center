class AddReqTransferTypeToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances, :req_transfer_type, :string
  end
end
