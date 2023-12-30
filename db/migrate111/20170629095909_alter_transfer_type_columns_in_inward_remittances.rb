class AlterTransferTypeColumnsInInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    #change_column :inward_remittances, :transfer_type, :string, limit: 10, :comment => "the type of the transfer which has been used for transactions (e.g. NEFT,FT,IMPS,RTGS)"  
    #change_column :inward_remittances, :req_transfer_type, :string, limit: 10, :comment => "the requested transfer type, can be different from used in transfer_type (e.g. NEFT,FT,IMPS,RTGS,THRIFTY,ANY)"
  end
end
