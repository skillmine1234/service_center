module EcolRemittersHelper
  def filter_ecol_remitter(params)
    if params[:incoming_file_id].present?
      ecol_remitters = EcolRemitter.where("incoming_file_id =?",params[:incoming_file_id]).order("id desc")
    else
      ecol_remitters = EcolRemitter.order("id desc")
    end
    ecol_remitters
  end

  def find_ecol_remitters(remitters,params)
    ecol_remitters = remitters
    ecol_remitters = ecol_remitters.where("customer_code=?",params[:customer_code]) if params[:customer_code].present?
    ecol_remitters = ecol_remitters.where("customer_subcode=?",params[:customer_subcode]) if params[:customer_subcode].present?
    ecol_remitters = ecol_remitters.where("remitter_code=?",params[:remitter_code]) if params[:remitter_code].present?
    ecol_remitters
  end
end
