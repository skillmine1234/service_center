module OutgoingFilesHelper
  def find_outgoing_files(params)
    outgoing_files = OutgoingFile
    outgoing_files = outgoing_files.where("service_code=?",params[:service_code]) if params[:service_code].present?
    outgoing_files = outgoing_files.where("file_type=?",params[:file_type]) if params[:file_type].present?
    outgoing_files = outgoing_files.where("lower(file_name) LIKE ?","%#{params[:file_name].downcase}%") if params[:file_name].present?
    outgoing_files
  end
end
