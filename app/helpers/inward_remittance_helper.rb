module InwardRemittanceHelper
  def find_inward_remittances(params)
    inw_remittances = InwardRemittance
    inw_remittances = inw_remittances.where("status_code=?",params[:status]) if params[:status].present?
    inw_remittances = inw_remittances.where("lower(req_no) LIKE ?","%#{params[:request_no].downcase}%") if params[:request_no].present?
    inw_remittances = inw_remittances.where("lower(partner_code) LIKE ?","%#{params[:partner_code].downcase}%") if params[:partner_code].present?
    inw_remittances = inw_remittances.where("req_transfer_type=?",params[:req_transfer_type]) if params[:req_transfer_type].present?
    inw_remittances = inw_remittances.where("transfer_type=?",params[:transfer_type]) if params[:transfer_type].present?
    inw_remittances = inw_remittances.where("transfer_amount>=? and transfer_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    inw_remittances = inw_remittances.where("req_timestamp>=? and req_timestamp<=?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:from_date].present? and params[:to_date].present?
    inw_remittances
  end
end