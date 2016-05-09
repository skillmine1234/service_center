module FtPurposeCodeHelper
  def find_ft_purpose_codes(params)
    ft_purpose_codes = FtPurposeCode
    ft_purpose_codes = ft_purpose_codes.where("lower(code)=?",params[:code].downcase) if params[:code].present?
    ft_purpose_codes = ft_purpose_codes.where("is_enabled=?",params[:enabled]) if params[:enabled].present?
    ft_purpose_codes
  end
end