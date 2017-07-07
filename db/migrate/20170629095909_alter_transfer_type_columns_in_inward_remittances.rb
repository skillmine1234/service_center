class AlterTransferTypeColumnsInInwardRemittances < ActiveRecord::Migration
  def change
    change_column :inward_remittances, :transfer_type, :string, limit: 10, :comment => "the transfer type of the transactions whether e.g. NEFT,FT,IMPS,RTGS,THRIFTY,ANY"  
    change_column :inward_remittances, :req_transfer_type, :string, limit: 10, :comment => "the transfer type of the transactions whether e.g. NEFT,FT,IMPS,RTGS,THRIFTY,ANY"
  end
end
