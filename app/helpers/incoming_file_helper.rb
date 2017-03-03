module IncomingFileHelper
  def find_incoming_files(params)
    incoming_files = (params[:approval_status].present? and params[:approval_status] == 'U') ? IncomingFile.unscoped.where("service_name =?",params[:sc_service]) : IncomingFile.where("service_name =?",params[:sc_service])
    incoming_files = incoming_files.where("file_type=?",params[:file_type]) if params[:file_type].present?
    incoming_files = incoming_files.where("file_name LIKE ?","#{params[:file_name]}%") if params[:file_name].present?
    incoming_files
  end

  def move_incoming_file(incoming_file)
    sf = CarrierWave::SanitizedFile.new incoming_file.file
    sc_service = incoming_file.sc_service.code.downcase
    file_type = incoming_file.incoming_file_type.code.downcase
    sf.move_to(Rails.root.join(ENV['CONFIG_APPROVED_FILE_UPLOAD_PATH'],sc_service,file_type,incoming_file.file_name), 0666)
  end

  def raw_file_content(file_content_str)
    file_content = nil
    file_content = file_content_str.gsub(/^\s+|\n\s+/, "\n") if file_content_str
    file_content
  end
end
