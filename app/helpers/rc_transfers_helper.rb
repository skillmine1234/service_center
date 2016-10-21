module RcTransfersHelper
  def find_logs(params,record)
    if params[:step_name] != 'ALL'
      record.rc_audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      record.rc_audit_steps.order("id desc") rescue []
    end      
  end

  def find_rc_transfers(params,records)
    rc_transfers = records
    rc_transfers = rc_transfers.where("rc_transfer_code=?", params[:rc_code]) if params[:rc_code].present?
    rc_transfers = rc_transfers.where("bene_account_no=?", params[:bene_account_no]) if params[:bene_account_no].present?
    rc_transfers = rc_transfers.where("debit_account_no=?", params[:debit_account_no]) if params[:debit_account_no].present?
    rc_transfers = rc_transfers.where("transfer_amount>=? and transfer_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    rc_transfers = rc_transfers.where("status_code=?",params[:status]) if params[:status].present?
    rc_transfers = rc_transfers.where("notify_status=?",params[:notify_status]) if params[:notify_status].present?
    rc_transfers = rc_transfers.where("mobile_no=?", params[:mobile_no]) if params[:mobile_no].present?
    rc_transfers = rc_transfers.where("pending_approval=?", params[:pending_approval]) if params[:pending_approval].present?
    rc_transfers
  end
end
