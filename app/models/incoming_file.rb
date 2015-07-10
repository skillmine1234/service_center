class IncomingFile < ActiveRecord::Base  
  include Approval

  SIZE_LIMIT = 50.megabytes.to_i
  validate :validate_file_name 
  validate :validate_unique_file
  validate :file_size, :on => [:create]

  validates_presence_of :service_name, :file_type

  BlackList = %w(exe vbs rb sh jar html msi bat com bin vb doc docx xlsx csv jpeg gif pdf png zip jpg)

  ExtensionList = %w(txt)

  before_create :update_size_and_file_name

  belongs_to :created_user, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updated_user, :class_name => 'User', :foreign_key => 'updated_by'
  has_many :ecol_remitters, :autosave => true
  belongs_to :sc_service, :foreign_key => 'service_name', :primary_key => 'code'
  belongs_to :incoming_file_type, :foreign_key => 'file_type', :primary_key => 'code'
  has_many :failed_records, -> { where status: 'FAILED' }, class_name: 'IncomingFileRecord'

  mount_uploader :file, IncomingFileUploader

  validates_presence_of :file, :on => :create
  
  def name
    file_name
  end

  def file_size
    unless file.file.nil?
      if file.file.size.to_f/(1000*1000) > SIZE_LIMIT.to_f/(1000*1000)
        limit = SIZE_LIMIT/(1000*1000).to_i
        errors.add(file.filename, "cannot be greater than #{limit} MB")
      end
    end
  end

  def validate_file_name
    if file.filename.present?
      file.filename.split(".").each do |ext|
        errors.add(:file, "Invalid file extension") and return false if BlackList.include?(ext)
      end
    end
  end

  def validate_unique_file
    if file.filename.present?
      if IncomingFile.unscoped.where("file_name=?",file.filename).count > 0
        errors.add(:file, "'#{file.file.original_filename}' already exists") and return false
      end
    end
  end

  def update_size_and_file_name
    self.size_in_bytes = self.file.file.try(:size).to_s
    self.file_name = self.file.filename if file_name.nil?
  end

  def job_status
    list = {'N': 'Not Started', 'I': 'In Progress', 'C': 'Completed', 'F': 'Failed'}
    list[status.to_sym]
  end

  def upload_time
    (ended_at - started_at).round(2) rescue '-'
  end
end