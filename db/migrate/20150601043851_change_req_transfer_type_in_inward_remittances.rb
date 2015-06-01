class ChangeReqTransferTypeInInwardRemittances < ActiveRecord::Migration
  def change
    change_column :inward_remittances, :req_transfer_type, :string, :limit => 4
  end
end
