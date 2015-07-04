module IncomingFileHelper
  def find_incoming_files(params)
    incoming_files = (params[:approval_status].present? and params[:approval_status] == 'U') ? IncomingFile.unscoped : IncomingFile
    incoming_files = incoming_files.where("service_name=?",params[:service_name]) if params[:service_name].present?
    incoming_files = incoming_files.where("file_type=?",params[:file_type]) if params[:file_type].present?
    incoming_files = incoming_files.where("lower(file_name) LIKE ?","%#{params[:file_name].downcase}%") if params[:file_name].present?
    incoming_files
  end

  def move_incoming_file(incoming_file)
    sf = CarrierWave::SanitizedFile.new incoming_file.file
    sf.move_to(Rails.root.join(ENV['CONFIG_APPROVED_FILE_UPLOAD_PATH'],incoming_file.file_name))
  end
end