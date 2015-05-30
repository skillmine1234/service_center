module InwardRemittanceHelper
  def find_inward_remittances(params)
    inw_remittances = InwardRemittance
    inw_remittances = inw_remittances.where("status_code=?",params[:status]) if params[:status].present?
    inw_remittances = inw_remittances.where("req_no=?",params[:request_no]) if params[:request_no].present?
    inw_remittances = inw_remittances.where("partner_code=?",params[:partner_code]) if params[:partner_code].present?
    inw_remittances = inw_remittances.where("transfer_type=?",params[:transfer_type]) if params[:transfer_type].present?
    inw_remittances = inw_remittances.where("transfer_ccy=?",params[:transfer_amount]) if params[:transfer_amount].present?
    inw_remittances = inw_remittances.where("req_timestamp>=? and req_timestamp<=?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:allow_imps].present?
    inw_remittances
  end
end