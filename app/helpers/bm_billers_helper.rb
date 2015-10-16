module BmBillersHelper

  def find_bm_billers(params)
    bm_billers = (params[:approval_status].present? and params[:approval_status] == 'U') ? BmBiller.unscoped : BmBiller
    bm_billers = bm_billers.where("biller_code=?",params[:biller_code]) if params[:biller_code].present?
    bm_billers = bm_billers.where("biller_name=?",params[:biller_name]) if params[:biller_name].present?
    bm_billers = bm_billers.where("biller_category=?",params[:biller_category]) if params[:biller_category].present?
    bm_billers = bm_billers.where("processing_method=?",params[:processing_method]) if params[:processing_method].present?
    bm_billers = bm_billers.where("is_enabled=?",params[:is_enabled]) if params[:is_enabled].present?
    bm_billers
  end

end
