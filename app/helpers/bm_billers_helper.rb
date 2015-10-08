module BmBillersHelper

  def find_bm_billers(params)
    bm_billers = (params[:approval_status].present? and params[:approval_status] == 'U') ? BmBiller.unscoped : BmBiller
    bm_billers = bm_billers.where("approval_status=?",params[:approval_status]) if params[:approval_status].present?
    bm_billers = bm_billers.where("biller_code=?",params[:code]) if params[:biller_code].present?
    bm_billers = bm_billers.where("is_enabled=?",params[:is_enabled]) if params[:is_enabled].present?
    bm_billers
  end

end
