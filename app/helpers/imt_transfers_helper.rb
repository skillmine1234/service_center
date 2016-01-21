module ImtTransfersHelper
  def find_imt_transfers(params)
    imt_transfers = ImtTransfer
    imt_transfers = imt_transfers.where("customer_id=?",params[:customer_id]) if params[:customer_id].present?
    imt_transfers = imt_transfers.where("status_code=?",params[:status]) if params[:status].present?
    imt_transfers = imt_transfers.where("transfer_amount>=? and transfer_amount<=?",params[:from_amount], params[:to_amount]) if params[:from_amount].present? and params[:to_amount].present?
    imt_transfers
  end
end
