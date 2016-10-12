module RcTransferSchedulesHelper
  def find_rc_transfer_schedules(params)
    rc_transfer_schedules = (params[:approval_status].present? and params[:approval_status] == 'U') ? RcTransferSchedule.unscoped : RcTransferSchedule
    rc_transfer_schedules = rc_transfer_schedules.where("code = ?", params[:code].downcase) if params[:code].present?
    rc_transfer_schedules
  end
end
