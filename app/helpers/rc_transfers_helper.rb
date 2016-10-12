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
    rc_transfers = rc_transfers.where("batch_no=?", params[:batch_no]) if params[:batch_no].present?
    rc_transfers = rc_transfers.where("started_at >= ? and started_at <= ?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:from_date].present? and params[:to_date].present?
    rc_transfers = rc_transfers.where("debit_account_no=?", params[:debit_account_no]) if params[:debit_account_no].present?
    rc_transfers
  end
end
