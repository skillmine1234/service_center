class IncomingFile < ActiveRecord::Base  
  include Approval

  lazy_load :fault_bitstream

  SIZE_LIMIT = 50.megabytes.to_i
  validate :validate_file_name 
  validate :validate_unique_file
  validate :file_size, :on => [:create]

  validates_presence_of :service_name, :file_type
  validates :file_name, length: { maximum: 50 }

  BlackList = %w(exe vbs rb sh jar html msi bat com bin vb doc docx xlsx jpeg gif pdf png zip jpg)

  ExtensionList = %w(txt csv)

  before_create :update_fields

  before_save :update_file_path

  belongs_to :created_user, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updated_user, :class_name => 'User', :foreign_key => 'updated_by'
  has_many :ecol_remitters, :autosave => true
  belongs_to :sc_service, :foreign_key => 'service_name', :primary_key => 'code'
  belongs_to :incoming_file_type, :foreign_key => 'file_type', :primary_key => 'code'
  has_many :failed_records, -> { where status: 'FAILED' }, class_name: 'IncomingFileRecord'
  has_many :incoming_file_records
  belongs_to :su_incoming_file, :foreign_key => "file_name", :primary_key => "file_name"
  belongs_to :ic_incoming_file, :foreign_key => "file_name", :primary_key => "file_name"
  belongs_to :ft_incoming_file, :foreign_key => "file_name", :primary_key => "file_name"
  belongs_to :pc_mm_cd_incoming_file, :foreign_key => "file_name", :primary_key => "file_name"
  belongs_to :cn_incoming_file, :foreign_key => "file_name", :primary_key => "file_name"
  has_many :fm_audit_steps, :as => :auditable

  has_one :ecol_unapproved_record, :as => :ecol_approvable
  has_one :imt_unapproved_record, :as => :imt_approvable
  has_one :inw_unapproved_record, :as => :inw_approvable
  has_one :su_unapproved_record, :as => :su_approvable
  has_one :ic_unapproved_record, :as => :ic_approvable
  has_one :ft_unapproved_record, :as => :ft_approvable
  has_one :pc_unapproved_record, :as => :pc_approvable
  has_one :cn_unapproved_record, :as => :cn_approvable

  after_create :on_create_create_unapproved_record
  after_destroy :on_destory_remove_unapproved_records
  after_update :on_update_remove_unapproved_records

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

  def update_fields
    self.size_in_bytes = self.file.file.try(:size).to_s
    self.line_count =  File.readlines(self.file.path).size
    self.file_name = self.file.filename if file_name.nil?
    self.failed_record_count = 0
    self.record_count = 0
    self.skipped_record_count = 0
    self.completed_record_count = 0
    self.timedout_record_count = 0
    self.alert_count = 0
    self.pending_approval = 'N'
  end

  def update_file_path
    self.file_path = self.approval_status == 'A' ? "#{ENV['CONFIG_APPROVED_FILE_UPLOAD_PATH']}/#{self.sc_service.code.downcase}/#{self.incoming_file_type.code.downcase}" : "#{ENV['CONFIG_FILE_UPLOAD_PATH']}"
  end

  def job_status
    pending_approval == 'Y' ? "Pending Approval" : status_text(status)
  end
  
  def status_text(status_code)
    list = {'N': 'Not Started', 'I': 'In Progress', 'C': 'Completed', 'F': 'Failed'}
    status_code.nil? ? nil : list[status_code.to_sym]
  end

  def upload_time
    (ended_at - started_at).round(2).to_s + ' Secs' rescue '-'
  end

  def auto_upload?
    incoming_file_type.auto_upload == 'Y'
  end

  def self.create_incoming_file
    Dir.foreach(ENV['CONFIG_AUTO_FILE_UPLOAD_PATH']) do |fname|
      next if fname == '.' or fname == '..' or fname == '.DS_Store'
      if IncomingFile.create(:file => File.new(ENV['CONFIG_AUTO_FILE_UPLOAD_PATH'] + "/" + fname), :service_name => 'Ecollect', :file_type => 'Remitters', :status => 'N')
        FileUtils.rm_f ENV['CONFIG_AUTO_FILE_UPLOAD_PATH'] + "/" + fname
      end
    end
  end

  def is_approved?
    approved = self.approval_status == 'A' ? true : false
    file_path = nil
    if Rails.env == "production"
      approved ?
          file_path = Rails.root.join(ENV['CONFIG_APPROVED_FILE_UPLOAD_PATH'], self.file_name) :
          file_path = Rails.root.join(ENV['CONFIG_FILE_UPLOAD_PATH'], self.file_name)
    else
      file_path = "#{Rails.root}/public#{self.file.url}"
    end
    result = {is_approved: approved, file_path: file_path}
    result
  end
  

  def on_create_create_unapproved_record
    if approval_status == 'U'
      EcolUnapprovedRecord.create!(:ecol_approvable => self) if self.service_name == "ECOL"
      ImtUnapprovedRecord.create!(:imt_approvable => self) if self.service_name == "IMTSERVICE"
      InwUnapprovedRecord.create!(:inw_approvable => self) if self.service_name == "AML"
      SuUnapprovedRecord.create!(:su_approvable => self) if self.service_name == "SALARY"
      IcUnapprovedRecord.create!(:ic_approvable => self) if self.service_name == "INSTANTCREDIT"
      FtUnapprovedRecord.create!(:ft_approvable => self) if self.service_name == "FUNDSTRANSFER"
      PcUnapprovedRecord.create!(:pc_approvable => self) if self.service_name == "PPC"
      CnUnapprovedRecord.create!(:cn_approvable => self) if self.service_name == "CNB"
    end
  end

  def on_destory_remove_unapproved_records
    if approval_status == 'U'
      ecol_unapproved_record.delete if self.service_name == "ECOL"
      imt_unapproved_record.delete if self.service_name == "IMTSERVICE"
      inw_unapproved_record.delete if self.service_name == "AML"
      su_unapproved_record.delete if self.service_name == "SALARY"
      ic_unapproved_record.delete if self.service_name == "INSTANTCREDIT"
      ft_unapproved_record.delete if self.service_name == "FUNDSTRANSFER"
      pc_unapproved_record.delete if self.service_name == "PPC"
      cn_unapproved_record.delete if self.service_name == "CNB"
    end
  end

  def on_update_remove_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      ecol_unapproved_record.delete if self.service_name == "ECOL"
      imt_unapproved_record.delete if self.service_name == "IMTSERVICE"
      inw_unapproved_record.delete if self.service_name == "AML"
      su_unapproved_record.delete if self.service_name == "SALARY"
      ic_unapproved_record.delete if self.service_name == "INSTANTCREDIT"
      ft_unapproved_record.delete if self.service_name == "FUNDSTRANSFER"
      pc_unapproved_record.delete if self.service_name == "PPC"
      cn_unapproved_record.delete if self.service_name == "CNB"
    end
  end 
end