module IncomingFileHelper
  def find_incoming_files(params)
    incoming_files = IncomingFile
    incoming_files = incoming_files.where("service_name=?",params[:service_name]) if params[:service_name].present?
    incoming_files = incoming_files.where("file_type=?",params[:file_type]) if params[:file_type].present?
    incoming_files = incoming_files.where("lower(file_name) LIKE ?","%#{params[:file_name].downcase}%") if params[:file_name].present?
    incoming_files
  end
end