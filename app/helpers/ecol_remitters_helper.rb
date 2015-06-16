module EcolRemittersHelper
  
  def find_ecol_remitters(params)
    ecol_remitters = EcolRemitter
    ecol_remitters = ecol_remitters.where("customer_code=?",params[:customer_code]) if params[:customer_code].present?
    ecol_remitters = ecol_remitters.where("customer_subcode=?",params[:customer_subcode]) if params[:customer_subcode].present?
    ecol_remitters = ecol_remitters.where("remitter_code=?",params[:remitter_code]) if params[:remitter_code].present?
    ecol_remitters
  end
end
