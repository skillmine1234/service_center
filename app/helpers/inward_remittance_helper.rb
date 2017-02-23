module InwardRemittanceHelper
  def find_inward_remittances(inward_remittance,params)
    inw_remittances = inward_remittance
    inw_remittances = inw_remittances.where("inward_remittances.status_code=?",params[:status]) if params[:status].present?
    inw_remittances = inw_remittances.where("inward_remittances.notify_status=?",params[:notify_status]) if params[:notify_status].present?
    inw_remittances = inw_remittances.where("inward_remittances.req_no LIKE ?","#{params[:request_no]}%") if params[:request_no].present?
    inw_remittances = inw_remittances.where("lower(inward_remittances.partner_code) LIKE ?","#{params[:partner_code].downcase}%") if params[:partner_code].present?
    inw_remittances = inw_remittances.where("inward_remittances.bank_ref=?",params[:bank_ref]) if params[:bank_ref].present?
    inw_remittances = inw_remittances.where("inward_remittances.rmtr_full_name=?",params[:rmtr_full_name]) if params[:rmtr_full_name].present?
    inw_remittances = inw_remittances.where("inward_remittances.req_transfer_type=?",params[:req_transfer_type]) if params[:req_transfer_type].present?
    inw_remittances = inw_remittances.where("inward_remittances.transfer_type=?",params[:transfer_type]) if params[:transfer_type].present?
    inw_remittances = inw_remittances.where("inward_remittances.transfer_amount>=? and inward_remittances.transfer_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    inw_remittances = inw_remittances.where("inward_remittances.req_timestamp>=? and inward_remittances.req_timestamp<=?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:from_date].present? and params[:to_date].present?
    inw_remittances
  end

  def find_logs(params,transaction)
    if params[:step_name] != 'ALL'
      transaction.audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      transaction.audit_steps.order("id desc") rescue []
    end      
  end
  
  def link_to_whitelisted_identity_path(inward_remittance, party)
    wl_id = inward_remittance.send("#{party}_wl_id")
    if wl_id.nil?
      if inward_remittance.send("#{party}_needs_wl") == 'Y'
        link_to 'Required : Add', new_whitelisted_identity_path(inw_id: inward_remittance.id, id_for: party[0].upcase)
      else
        '-'
      end
    else
      link_to 'show', whitelisted_identity_path(wl_id)
    end
  end
end